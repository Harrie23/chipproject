import angles::*;
import coordinates::*;
import render_parameters::*;
module pointrender(
    input logic [WCX-1:0] rawpointx,
    input logic [WCY-1:0] rawpointy,
    input logic [WCZ-1:0] rawpointz,

    input logic [WCX-1:0] camerax,
    input logic [WCY-1:0] cameray,
    input logic [WCZ-1:0] cameraz,

    input logic [ANGLEX-1:0] camera_anglex,
    input logic [ANGLEY-1:0] camera_angley,

    output logic [SCX-1:0] renderpointx,
    output logic [SCY-1:0] renderpointy
);


logic [CCX-1:0] ccsx;
logic [CCY-1:0] ccsy;
logic [CCZ-1:0] ccsz;


logic [OFFSET_BITS+1:0] sinx; //signed needs to be specified when opperations takes place without module
logic [OFFSET_BITS+1:0] cosx;

logic [OFFSET_BITS+1:0] siny;
logic [OFFSET_BITS+1:0] cosy;

logic [OFFSET_BITS+1:0] mulx1;
logic [OFFSET_BITS+1:0] mulx2;
logic [OFFSET_BITS+1:0] subx;
logic [OFFSET_BITS+2:0] addx;

logic [OFFSET_BITS+2:0] addy;

logic [OFFSET_BITS+1:0] mulz1;
logic [OFFSET_BITS+1:0] mulz2;
logic [OFFSET_BITS+1:0] subz;
logic [OFFSET_BITS+2:0] addz;

logic [CCX:0] pointcamerax;
logic [CCY:0] pointcameray;
logic [CCZ:0] pointcameraz;

logic [CCX+FOCAL_BITS-1:0] projx;
logic [CCX+FOCAL_BITS-1:0] projy;

//making camera center in cordinates
minus_coordinates x1 (rawpointx[WCX-1:0], camerax[WCX-1:0], ccsx[CCX-1:0]);
minus_coordinates y1 (rawpointy[WCY-1:0], cameray[WCY-1:0], ccsy[CCY-1:0]);
minus_coordinates z1 (rawpointz[WCZ-1:0] , cameraz[WCZ-1:0] , ccsz[CCZ-1:0]);

//setting rotation by 2 times matrix multiplication for 2 angels for x

sincos x2 (1'b0, camera_anglex[ANGLEX-1:0], sinx[OFFSET_BITS+1:0]);
sincos x3 (1'b1, camera_anglex[ANGLEX-1:0], cosx[OFFSET_BITS+1:0]);

sincos y2 (1'b0, camera_angley[ANGLEY-1:0], siny[OFFSET_BITS+1:0]);
sincos y3 (1'b1, camera_angley[ANGLEY-1:0], cosy[OFFSET_BITS+1:0]);

//pointcamera x
trig_multi x4 (sinx[OFFSET_BITS+1:0], siny[OFFSET_BITS+1:0], mulx1[OFFSET_BITS+1:0]);
trig_multi x5 (cosx[OFFSET_BITS+1:0], siny[OFFSET_BITS+1:0], mulx2[OFFSET_BITS+1:0]);

trig_minus x6 (mulx1[OFFSET_BITS+1:0], mulx2[OFFSET_BITS+1:0], subx[OFFSET_BITS+1:0]); 

trig_add x7 (cosx[OFFSET_BITS+1:0], subx[OFFSET_BITS+1:0], addx[OFFSET_BITS+2:0]);

scale_multi x8 (ccsx[CCX-1:0],addx[OFFSET_BITS+2:0],pointcamerax[CCX:0]);

//pointcamera y

trig_add y4 (cosy[OFFSET_BITS+1:0], siny[OFFSET_BITS+1:0], addy[OFFSET_BITS+2:0]);

scale_multi y5 (ccsy[CCY-1:0], addy[OFFSET_BITS+2:0], pointcameray[CCY:0]);

//pointcamera z

trig_multi z2 (sinx[OFFSET_BITS+1:0], cosy[OFFSET_BITS+1:0], mulz1[OFFSET_BITS+1:0]);
trig_multi z3 (cosx[OFFSET_BITS+1:0], cosy[OFFSET_BITS+1:0], mulz2[OFFSET_BITS+1:0]);

trig_minus z4 (mulz2[OFFSET_BITS+1:0], mulz1[OFFSET_BITS+1:0], subz[OFFSET_BITS+1:0]); 

trig_add z5 (siny[OFFSET_BITS+1:0], subz[OFFSET_BITS+1:0], addz[OFFSET_BITS+2:0]);

scale_multi z6 (ccsz[CCZ-1:0],addz[OFFSET_BITS+2:0],pointcameraz[CCZ:0]);

//perspective projection

focal_mult x9 (pointcamerax[CCX:0], projx[CCX+FOCAL_BITS-1:0]);
projx_div x10 (projx[CCX+FOCAL_BITS-1:0], pointcameraz[CCZ:0], renderpointx[SCX-1:0]);

focal_mult y6 (pointcameray[CCY:0], projy[CCX+FOCAL_BITS-1:0]);
projy_div y7 (projy[CCX+FOCAL_BITS-1:0], pointcameraz[CCZ:0], renderpointy[SCY-1:0]);



endmodule