import angles::*;

module sincos(
    input logic sin,    //zero for cos, one for sine    
    input logic [ANGLE_LENGTH-1:0] angle,
    output logic signed [OFFSET_BITS+1:0] calculation //is signed
);

    logic [LUT_LENGTH-1:0][OFFSET_BITS+1:0] sin_lut;
    logic [ANGLE_LENGTH-1:0] angle_precalc;

    always_comb begin
        if(sin)begin
            angle_precalc = angle;
        end
        else begin
            if (angle > 90)begin
                angle_precalc = angle - 90;
            end
            else begin
                angle_precalc = angle + 270;
            end
        end

        if(angle_precalc < 90)begin
            calculation = $signed(sin_lut[angle_precalc]);
        end
        else if((angle_precalc > 89) && (angle_precalc < 180))begin
            calculation = $signed(sin_lut[180 - angle_precalc]);
        end
        else if((angle_precalc > 179) && (angle_precalc < 270))begin
            calculation = -$signed(sin_lut[angle_precalc - 180]);
        end
        else begin
            calculation = -$signed(sin_lut[360 - angle_precalc]);
        end
    end 



    initial begin
        sin_lut[0]  =       0;
        sin_lut[1]  =       286;
        sin_lut[2]  =       572;
        sin_lut[3]  =       857;
        sin_lut[4]  =       1143;
        sin_lut[5]  =       1428;
        sin_lut[6]  =       1713;
        sin_lut[7]  =       1997;
        sin_lut[8]  =       2280;
        sin_lut[9]  =       2563;
        sin_lut[10]  =      2845;
        sin_lut[11]  =      3126;
        sin_lut[12]  =      3406;
        sin_lut[13]  =      3686;
        sin_lut[14]  =      3964;
        sin_lut[15]  =      4240;
        sin_lut[16]  =      4516;
        sin_lut[17]  =      4790;
        sin_lut[18]  =      5063;
        sin_lut[19]  =      5334;
        sin_lut[20]  =      5604;
        sin_lut[21]  =      5872;
        sin_lut[22]  =      6138;
        sin_lut[23]  =      6402;
        sin_lut[24]  =      6664;
        sin_lut[25]  =      6924;
        sin_lut[26]  =      7182;
        sin_lut[27]  =      7438;
        sin_lut[28]  =      7692;
        sin_lut[29]  =      7943;
        sin_lut[30]  =      8192;
        sin_lut[31]  =      8438;
        sin_lut[32]  =      8682;
        sin_lut[33]  =      8923;
        sin_lut[34]  =      9162;
        sin_lut[35]  =      9397;
        sin_lut[36]  =      9630;
        sin_lut[37]  =      9860;
        sin_lut[38]  =      10087;
        sin_lut[39]  =      10311;
        sin_lut[40]  =      10531;
        sin_lut[41]  =      10749;
        sin_lut[42]  =      10963;
        sin_lut[43]  =      11174;
        sin_lut[44]  =      11381;
        sin_lut[45]  =      11585;
        sin_lut[46]  =      11786;
        sin_lut[47]  =      11982;
        sin_lut[48]  =      12176;
        sin_lut[49]  =      12365;
        sin_lut[50]  =      12551;
        sin_lut[51]  =      12733;
        sin_lut[52]  =      12911;
        sin_lut[53]  =      13085;
        sin_lut[54]  =      13255;
        sin_lut[55]  =      13421;
        sin_lut[56]  =      13583;
        sin_lut[57]  =      13741;
        sin_lut[58]  =      13894;
        sin_lut[59]  =      14044;
        sin_lut[60]  =      14189;
        sin_lut[61]  =      14330;
        sin_lut[62]  =      14466;
        sin_lut[63]  =      14598;
        sin_lut[64]  =      14726;
        sin_lut[65]  =      14849;
        sin_lut[66]  =      14968;
        sin_lut[67]  =      15082;
        sin_lut[68]  =      15191;
        sin_lut[69]  =      15296;
        sin_lut[70]  =      15396;
        sin_lut[71]  =      15491;
        sin_lut[72]  =      15582;
        sin_lut[73]  =      15668;
        sin_lut[74]  =      15749;
        sin_lut[75]  =      15826;
        sin_lut[76]  =      15897;
        sin_lut[77]  =      15964;
        sin_lut[78]  =      16026;
        sin_lut[79]  =      16083;
        sin_lut[80]  =      16135;
        sin_lut[81]  =      16182;
        sin_lut[82]  =      16225;
        sin_lut[83]  =      16262;
        sin_lut[84]  =      16294;
        sin_lut[85]  =      16322;
        sin_lut[86]  =      16344;
        sin_lut[87]  =      16362;
        sin_lut[88]  =      16374;
        sin_lut[89]  =      16382;
        sin_lut[90]  =      16384;
    end


endmodule