/*****************************************************************************--
-- PROJECT  : RF-SOM demo program
-- FileName : main.c
-- Function : WLAN11a demo program
--
-- Copyright (c) 2023  Marimo Electronics Co.,Ltd..  All rights reserved.
--
--*****************************************************************************
-- modification history
--*****************************************************************************
-- Rev. 1.00 : 2023/08/10  Marimo Electronics.

                                                                             */
/******************************************************************************
** Define
******************************************************************************/
/***** mmap base address *****/
#define FPGA_MODEM_BASE  0xFF290000
#define FPGA_9002_BASE   0xFF220000
#define FPGA_GPIO_BASE   0xFF200000
#define FPGA_BLK_SIZE    0x10000

/***** ADRV9002 control *****/
#define AOFS_DAC_DSEL1 0x00000906
#define AOFS_DAC_DSEL2 0x00000916
#define AOFS_DAC_DSEL3 0x00000926
#define AOFS_DAC_DSEL4 0x00000936
#define DAT_DSEL_USER  0x00000002

/***** MODEM control *****/
/***** Address offset *****/
#define AOFS_TX_CTRL   0x00000000/4  // Transmit control register
#define AOFS_TX_STS    0x00000010/4  // Transmit status  register
#define AOFS_RX_CTRL   0x00000020/4  // Receive  control register
#define AOFS_RX_STS    0x00000030/4  // Receive  status  register
#define AOFS_RX_MEM    0x00004000/4  // Transmit data memory
#define AOFS_TX_MEM    0x00008000/4  // Receive  data memory
/***** Register bit *****/
#define DAT_TX_OFF     0x00000000    // Transmit modem disable
#define DAT_TX_ACT     0xC0000000    // Transmit modem enable
#define DAT_TX_PUSH    0x08000000    // Transmit data  push
#define DAT_RX_OFF     0x00000000    // Receive  modem disable
#define DAT_RX_ACT     0x40000000    // Receive  modem enable
#define DAT_RX_PULL    0x08000000    // Receive  data  pull
/***** Register mask bit *****/
#define MASK_PCNT      0x00000300    // Receive Number of packet
#define MASK_RPTR      0x00000030    // Receive packet pointer
#define MASK_WPTR      0x00000003    // Transmit packet pointer
#define MASK_CRC       0x80000000    // CRC error bit
#define MASK_LEN       0x00000FFF    // Packet length
#define MASK_10MS      0x00008000    // 10ms toggle bit
#define PCNT_FULL      3 // Number of packet full
#define DAT_TX_MCS     5 // QPSK 1/2(Refer 802.11a standard)

/***** GPIO control *****/
/***** Address offset *****/
#define AOFS_GPIO_BD   0x000000D0/4
/***** Register mask bit *****/
#define MASK_LED0      0x00000001
#define MASK_LED1      0x00000002
#define MASK_LED2      0x00000004
#define MASK_LED3      0x00000008
#define MASK_BTN0      0x00000010
#define MASK_BTN2      0x00000020
#define MASK_DIP0      0x00000040
#define MASK_DIP1      0x00000080
#define MASK_DIP2      0x00000100
#define MASK_DIP3      0x00000200

/***** Receive interface *****/
#define RBUF_NUM       32

/***** TIME *****/
#define TIME_1000ms 1000000

/*******************************************************************************
** Include
*******************************************************************************/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <dirent.h>
#include <fcntl.h>
#include <termios.h>
#include <assert.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <netinet/in.h>
#include <arpa/inet.h>
/*******************************************************************************
** Global
*******************************************************************************/
int      gFD;
char     *gFPGA_MODEM_map;
char     *gFPGA_9002_map;
char     *gFPGA_GPIO_map;
volatile unsigned *gFPGA_MODEM_BASE;
volatile unsigned *gFPGA_9002_BASE;
volatile unsigned *gFPGA_GPIO_BASE;
/*******************************************************************************
** function
*******************************************************************************/
void setup_FPGA_IO();


/*****************************************************************************--
-- name    : main
-- Input   : (none)
-- Output  : (none)
--
-- Overview:
--  This function is a demonstration program for transmit/receive RF-SOMs.
--*****************************************************************************/
int main( int argc, char* argv[] )
{
    /*************************************************************************--
    -- argv
    --*************************************************************************/
    char* sadr = "192.168.1.228";
    sadr = argv[1];
    /*************************************************************************--
    -- Variable definitions
    --*************************************************************************/
    int            i;
    int            SEQ_NUM     = 0;
    int            TX_STS      = 0;
    int            TX_WPTR     = 0;
    int            TX_PCNT     = 0;
    int            RX_STS      = 0;
    int            RX_RPTR     = 0;
    int            RX_PCNT     = 0;
    int            RX_LEN      = 0;
    unsigned long  RCV_DAT     = 0;
    unsigned long  RCV_ADR[2];
    int            RX_10MS     = 0;
    int            RX_10MS_D   = 0;
    int            RX_100MS_CNT= 0;
    unsigned long  GPIO_DAT    = 0;
    int            STS_DIP0    = 0;
    int            GPIO_TX     = 0;
    int            GPIO_RX     = 0;
    /* ----- UDP receive ----- */
    char           RBUF[RBUF_NUM][2048];
    int            RBUF_WPTR = 0;
    int            RBUF_RPTR = 0;
    int            RLEN[RBUF_NUM] = {};
    int            val;
    int            sock;
    struct sockaddr_in addr;
    struct sockaddr_in senderinfo;
    socklen_t addrlen;
    /* ----- UDP transmit ----- */
    char           TBUF[2048];
    int            TBUF_PTR = 0;
    int            sock_tx;
    struct sockaddr_in addr_tx;
    /* ----- Transmit MAC Header ----- */
    unsigned long MAC_HEADER[6] = {
        0x20000000,
        0x70B3D502,
        0x904070B3,
        0xD5029041,
        0x01020304,
        0x05060000
    };
    /* ----- Receive MAC address ----- */
    unsigned long RCV_MAC_ADR[2] = {
        0x70B3D502,
        0x90400000
    };
    /*************************************************************************--
    -- Initial setting
    --*************************************************************************/
    printf("----------------------------------------------------------------------\n");
    printf("------ WLAN11a transmit and receive program. ------\n");
    /*************************************************************************--
    -- Setup PS<->PL interface
    --*************************************************************************/
    printf("INFO-> Setup FPGA interface... ");
    setup_FPGA_IO();
    printf("finished.\n");
    /*************************************************************************--
    -- Turn off all LEDs
    --*************************************************************************/
    GPIO_DAT  = *((unsigned long*)gFPGA_GPIO_BASE+AOFS_GPIO_BD);
    GPIO_DAT  = GPIO_DAT | MASK_LED0 | MASK_LED1 | MASK_LED2 | MASK_LED3;
    *(gFPGA_GPIO_BASE+AOFS_GPIO_BD) = GPIO_DAT;
    /*************************************************************************--
    -- Get DIP switch status
    --*************************************************************************/
    STS_DIP0 = ((GPIO_DAT & MASK_DIP0) == 0);
    /*************************************************************************--
    -- ADRV9002 initial setting
    --*************************************************************************/
    printf("INFO-> Initialize RF wideband transceiver(ADRV9002)... ");
    system("sh /home/analog/yonaguni_wlan11a_demo/SW/00_SH/00_SET_INIT.sh");
    usleep(TIME_1000ms);
    /*************************************************************************--
    -- Change the DAC output of axi_adrv9002 from DDS to USER data.
    -- [13: 8] 0x11: DAC / 0x01: ADC
    -- [ 7: 4] Channel  select 0:D0_I / 1:D0_Q / 2:D1_I / 3:D1_Q
    -- [ 3: 0] Register select
    --*************************************************************************/
    *(gFPGA_9002_BASE+AOFS_DAC_DSEL1) = DAT_DSEL_USER;
    *(gFPGA_9002_BASE+AOFS_DAC_DSEL2) = DAT_DSEL_USER;
    *(gFPGA_9002_BASE+AOFS_DAC_DSEL3) = DAT_DSEL_USER;
    *(gFPGA_9002_BASE+AOFS_DAC_DSEL4) = DAT_DSEL_USER;
    printf("finished.\n");
    /*************************************************************************--
    -- UDP receive setting
    --*************************************************************************/
    sock = socket(AF_INET, SOCK_DGRAM, 0);
    addr.sin_family = AF_INET;
    addr.sin_port = htons(25000);
    addr.sin_addr.s_addr = INADDR_ANY;
    bind(sock, (struct sockaddr *)&addr, sizeof(addr));
    val = 1;  // 0:Blocking mode / 1:Non blocking mode
    ioctl(sock, FIONBIO, &val);
    /*************************************************************************--
    -- UDP transmit setting
    --*************************************************************************/
    sock_tx = socket(AF_INET, SOCK_DGRAM, 0);
    addr_tx.sin_family = AF_INET;
    addr_tx.sin_port = htons(25000);
    printf("INFO-> Source IP address is %s\n", sadr);
    addr_tx.sin_addr.s_addr = inet_addr(sadr);
    if (STS_DIP0 != 0) { // LED[2] is turned on.
        GPIO_DAT = *((unsigned long*)gFPGA_GPIO_BASE+AOFS_GPIO_BD);
        GPIO_DAT = GPIO_DAT ^ MASK_LED2; // LED[2] is on
        *(gFPGA_GPIO_BASE+AOFS_GPIO_BD) = GPIO_DAT;
    }
    /*************************************************************************--
    -- WLAN11a transmit and receive start
    --*************************************************************************/
    *(gFPGA_MODEM_BASE+AOFS_TX_CTRL) = DAT_TX_OFF;
    *(gFPGA_MODEM_BASE+AOFS_RX_CTRL) = DAT_RX_OFF;
    usleep(TIME_1000ms);
    *(gFPGA_MODEM_BASE+AOFS_TX_CTRL) = DAT_TX_ACT;
    *(gFPGA_MODEM_BASE+AOFS_RX_CTRL) = DAT_RX_ACT;
    printf("INFO-> ready...\n");
    while (1) {
        /*********************************************************************--
        -- Receive process
        --*********************************************************************/
        /*********************************************************************--
        -- Get receive status register
        --*********************************************************************/
        RX_STS  = *((unsigned long*)gFPGA_MODEM_BASE+AOFS_RX_STS);
        RX_PCNT = (RX_STS & MASK_PCNT)/256;
        RX_RPTR = (RX_STS & MASK_RPTR)/16 * 4096/4;
        RX_10MS_D = RX_10MS;
        RX_10MS   = (RX_STS & MASK_10MS)/32768;
        /*********************************************************************--
        -- Wireless data received
        --*********************************************************************/
        if (RX_PCNT != 0) {
            // printf("DEBUG> 802.11 packet received.\n");
            /*****************************************************************--
            -- Check CRC
            --*****************************************************************/
            RCV_DAT = *((unsigned long*)gFPGA_MODEM_BASE+AOFS_RX_MEM+RX_RPTR+0);
            if ((RCV_DAT & MASK_CRC) == 0) {   // CRC OK
                /*************************************************************--
                -- Check MAC address
                -- Note: Source MAC address is stored in 5 .. 10 bytes.
                --*************************************************************/
                RCV_ADR[0] = *((unsigned long*)gFPGA_MODEM_BASE+AOFS_RX_MEM+RX_RPTR+9+0);
                RCV_ADR[1] = *((unsigned long*)gFPGA_MODEM_BASE+AOFS_RX_MEM+RX_RPTR+9+1);
                RCV_ADR[1] = RCV_ADR[1] & 0xFFFF0000;
                if ((RCV_ADR[0] == RCV_MAC_ADR[0]) && (RCV_ADR[1] == RCV_MAC_ADR[1])) {
                    TBUF_PTR = 0;
                    RX_LEN   = (RCV_DAT & MASK_LEN) - 24;
                    /*********************************************************--
                    -- Transfers received data to the transmit buffer
                    -- Note: Copies received data to the send buffer
                    --*********************************************************/
                    while (TBUF_PTR < RX_LEN) {
                        RCV_DAT = *((unsigned long*)gFPGA_MODEM_BASE+AOFS_RX_MEM+RX_RPTR+8+6+TBUF_PTR/4);
                        TBUF[TBUF_PTR+0] = (char)((RCV_DAT>>24) & 0x000000FF);
                        TBUF[TBUF_PTR+1] = (char)((RCV_DAT>>16) & 0x000000FF);
                        TBUF[TBUF_PTR+2] = (char)((RCV_DAT>> 8) & 0x000000FF);
                        TBUF[TBUF_PTR+3] = (char)((RCV_DAT    ) & 0x000000FF);
                        TBUF_PTR = TBUF_PTR + 4;
                    }
                    /*********************************************************--
                    -- Send UDP packet
                    --*********************************************************/
                    sendto(sock_tx, TBUF, RX_LEN, 0, (struct sockaddr *)&addr_tx, sizeof(addr_tx));
                    GPIO_RX = 1;
                } else {
                    printf("DEBUG-> MACAdr not matched.\n");
                }
            } else {
                printf("DEBUG-> CRC err.\n");
            }
            /*****************************************************************--
            -- Pull Received buffer
            --*****************************************************************/
            *(gFPGA_MODEM_BASE+AOFS_RX_CTRL) = DAT_RX_ACT + DAT_RX_PULL;
            *(gFPGA_MODEM_BASE+AOFS_RX_CTRL) = DAT_RX_ACT;
        }
        /*********************************************************************--
        -- Transmit process
        --*********************************************************************/
        /*********************************************************************--
        -- Receive UDP packet
        --*********************************************************************/
        addrlen = sizeof(senderinfo);
        RLEN[RBUF_WPTR] = recvfrom(sock, RBUF[RBUF_WPTR],
          sizeof(RBUF[RBUF_WPTR])-1, 0, (struct sockaddr *)&senderinfo, &addrlen);
        if ( RLEN[RBUF_WPTR] > 1 ) {
            RBUF_WPTR = (RBUF_WPTR+1) % RBUF_NUM;
            if (RBUF_WPTR == RBUF_RPTR) {
                printf("ERROR-> Receive buffer overflow is happen!!\n");
                fflush(stdout);
            }
        }
        /*********************************************************************--
        -- Transmit WLAN11a packet
        --*********************************************************************/
        /*********************************************************************--
        -- Transmit write pointer
        --*********************************************************************/
        TX_STS  = *((unsigned long*)gFPGA_MODEM_BASE+AOFS_TX_STS);
        TX_PCNT = (TX_STS & MASK_PCNT)/256;
        TX_WPTR = (TX_STS & MASK_WPTR) * 4096/4;
        if ((RBUF_WPTR != RBUF_RPTR) && (TX_PCNT != PCNT_FULL)) {
            /*****************************************************************--
            -- TX VECTOR
            --*****************************************************************/
            *(gFPGA_MODEM_BASE+AOFS_TX_MEM+TX_WPTR) =
                DAT_TX_MCS*4096 + RLEN[RBUF_RPTR]+24;
            /*****************************************************************--
            -- MAC Header
            --*****************************************************************/
            for(i=0;i<6;i++) {
                *(gFPGA_MODEM_BASE+AOFS_TX_MEM+TX_WPTR+8+i) = MAC_HEADER[i];
            }
            /*****************************************************************--
            -- Update WLAN Sequence number
            --*****************************************************************/
            SEQ_NUM = (SEQ_NUM+1) % 4096;
            *(gFPGA_MODEM_BASE+AOFS_TX_MEM+TX_WPTR+8+5) = MAC_HEADER[5] + SEQ_NUM;
            /*****************************************************************--
            -- Transmit data
            --*****************************************************************/
            for(i=0;i<(RLEN[RBUF_RPTR]+4+4)/4;i++) {
                *(gFPGA_MODEM_BASE+AOFS_TX_MEM+TX_WPTR+8+6+i) =
                    RBUF[RBUF_RPTR][i*4+0]*16777216 + RBUF[RBUF_RPTR][i*4+1]*65536 +
                    RBUF[RBUF_RPTR][i*4+2]*256      + RBUF[RBUF_RPTR][i*4+3]       ;
            }
            /*****************************************************************--
            -- Data transmit request
            --*****************************************************************/
            *(gFPGA_MODEM_BASE+AOFS_TX_CTRL) = DAT_TX_ACT + DAT_TX_PUSH;
            *(gFPGA_MODEM_BASE+AOFS_TX_CTRL) = DAT_TX_ACT;
            RBUF_RPTR = (RBUF_RPTR+1) % RBUF_NUM;
            GPIO_TX = 1;
        }
        /*********************************************************************--
        -- SW & LED
        --*********************************************************************/
        if (RX_10MS_D != RX_10MS) {
            /*****************************************************************--
            -- Control the LEDs with a cycle of 100 ms
            -- Note: RX_10MS toggles in 10ms, so the LED is controlled
            --       when the transition is counted 10 times.
            --*****************************************************************/
            if (RX_100MS_CNT == 9) {
                RX_100MS_CNT = 0;
                GPIO_DAT = *((unsigned long*)gFPGA_GPIO_BASE+AOFS_GPIO_BD);
                /*************************************************************--
                -- Transmit / Receive status LED
                --*************************************************************/
                GPIO_DAT = GPIO_DAT | MASK_LED1 | MASK_LED0;
                GPIO_DAT = GPIO_DAT & (((GPIO_RX*2) | GPIO_TX) ^ 0xFFFFFFFF);
                GPIO_TX  = 0;
                GPIO_RX  = 0;
                /*************************************************************--
                -- Heartbeat LED
                --*************************************************************/
                GPIO_DAT = GPIO_DAT ^ MASK_LED3; // Toggle LED[3]
                *(gFPGA_GPIO_BASE+AOFS_GPIO_BD) = GPIO_DAT;
                /*************************************************************--
                -- Exit the function when the button is pressed.
                --*************************************************************/
                if ((GPIO_DAT & MASK_BTN0) == 0) {
                    close(sock_tx);
                    close(sock);
                    return 0;
                }
            }
            else {
                RX_100MS_CNT = RX_100MS_CNT + 1;
            }
        }
    }
}


/*****************************************************************************--
-- name    : setup_FPGA_IO
-- Input   : (none)
-- Output  : (none)
--
-- Overview: This function maps the memory space required for FPGA access.
--*****************************************************************************/
void setup_FPGA_IO()
{
    /* ---- MODEM access pointer ----- */
    gFD = open("/dev/mem", O_RDWR|O_SYNC);
    gFPGA_MODEM_map = mmap(NULL, FPGA_BLK_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, gFD, FPGA_MODEM_BASE );
    if(gFPGA_MODEM_map == NULL){
        printf("ERR-> PL MODEM mmap is failed.\n");
        // return -1;
    }
    gFPGA_MODEM_BASE = (volatile unsigned *)gFPGA_MODEM_map;
    close(gFD);

    /* ---- AXI_ADRV9002 access pointer ----- */
    gFD = open("/dev/mem", O_RDWR|O_SYNC);
    gFPGA_9002_map = mmap(NULL, FPGA_BLK_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, gFD, FPGA_9002_BASE );
    if(gFPGA_9002_map == NULL){
        printf("ERR-> AD9002 mmap is failed.\n");
        // return -1;
    }
    gFPGA_9002_BASE = (volatile unsigned *)gFPGA_9002_map;
    close(gFD);

    /* ---- GPIO access pointer ----- */
    gFD = open("/dev/mem", O_RDWR|O_SYNC);
    gFPGA_GPIO_map = mmap(NULL, FPGA_BLK_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, gFD, FPGA_GPIO_BASE );
    if(gFPGA_GPIO_map == NULL){
        printf("ERR-> PL GPIO mmap is failed.\n");
        // return -1;
    }
    gFPGA_GPIO_BASE = (volatile unsigned *)gFPGA_GPIO_map;
    close(gFD);

}
