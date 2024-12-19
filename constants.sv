

package angles;
    parameter LUT_LENGTH = 7;
    parameter ANGLE_LENGTH = 9;
    parameter OFFSET_BITS = 14; //also needs change in module because of lookuptable with the excelsheet
    parameter OFFSET_BITS_TWO = 28;

    parameter TOTAL_ANGLE = 18;
    parameter ANGLEX = 9;
    parameter ANGLEY = 18;

endpackage

//point render

package coordinates;
//screen(SCS)
    parameter TOTAL_SC = 23;
    parameter SCX = 12; //640 plus 2 extra bits for render space
    parameter SCY = 23; //480
//camera(CCS)
    parameter TOTAL_CC = 42; 
    parameter CCX = 14; //8192 signed
    parameter CCY = 28; //8192 signed
    parameter CCZ = 42; //8192 signed
//world(WCS)
    parameter TOTAL_WC = 42; 
    parameter WCX = 14; //8192 delta WCZ, WCY need to be lower or equal then WCX
    parameter WCY = 28; //8192 signed
    parameter WCZ = 42; //8192
endpackage

package render_parameters;
    //focal length camera
    parameter FOCAL = 320;  //calculated with 90 degrees FOVx
    parameter FOCAL_BITS = 10; //signed
endpackage

package vga_c;
    parameter SCW = 640;
    parameter SCH = 480;

    parameter CX = 10;
    parameter CY = 9:

    parameter W = 799;
    parameter H = 524;

    parameter TOTAL_LED = 12;
    parameter R = 4;
    parameter G = 4;
    parameter B = 4;

    parameter FRONT_PORCH_V = 10;
    parameter FRONT_PORCH_V_AND_SYNC = 12;

    parameter FRONT_PORCH_H = 16;
    parameter FRONT_PORCH_H_AND_SYNC = 112;
endpackage

package world_par;
    parameter SURFACEID = 6;
endpackage

package synchronize;
    parameter COUNTBIT = 10;
    parameter COUNTHEIGHT = 1024;
endpackage

package spi_con;
    parameter START_HWRITE = 524;
    parameter OPCODEBITS = 8;
    parameter ADDRESSBITS = 24;
endpackage

package test_var;
    parameter CAMERA = 42'b00001111101000 00001111101000 00001100100000;
    parameter POINTA = 42'b00001111101000 00001111101000 00001111101000;
    parameter POINTB = 42'b00010001001100 00001111101000 00001111101000;
    parameter POINTC = 42'b00010001001100 00010001001100 00001111101000;
    parameter POINTD = 42'b00001111101000 00010001001100 00001111101000;
endpackage