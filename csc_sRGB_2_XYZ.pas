unit csc_sRGB_2_XYZ;

// http://www.easyrgb.com/en/math.php

{$mode objfpc}{$H+}

interface

uses
  math,
  cs_types;

//sR, sG and sB (Standard RGB) input range = 0 ÷ 255
//X, Y and Z output refer to a D65/2° standard illuminant.
//  http://www.easyrgb.com/en/math.php



procedure sRGB_2_XYZ(const sR,sG,sB:t_sRGB_colorComp; out X,Y,Z:t_XYZ_colorComp);

implementation

type tCalculations=t_csIntermediateCalculations;

procedure sRGB_2_XYZ(const sR,sG,sB:t_sRGB_colorComp; out X,Y,Z:t_XYZ_colorComp);
var var_R:tCalculations;
    var_G:tCalculations;
    var_B:tCalculations;
begin
   var_R:=sR/255;
   var_G:=sG/255;
   var_B:=sB/255;

   if var_R>0.04045 then var_R:=power( (var_R+0.055)/1.055 , 2.4 )
                    else var_R:=var_R/12.92;
   if var_G>0.04045 then var_G:=power( (var_G+0.055)/1.055 , 2.4 )
                    else var_G:=var_G/12.92;
   if var_B>0.04045 then var_B:=power( (var_B+0.055)/1.055 , 2.4 )
                    else var_B:=var_B/12.92;

   var_R:=var_R*100;
   var_G:=var_G*100;
   var_B:=var_B*100;

   // предложенное с
   // http://www.easyrgb.com/en/math.php
   //X:= var_R*0.4124 + var_G*0.3576 + var_B*0.1805;
   //Y:= var_R*0.2126 + var_G*0.7152 + var_B*0.0722;
   //Z:= var_R*0.0193 + var_G*0.1192 + var_B*0.9505;

   // более "точные" значения констант
   // http://cs.haifa.ac.il/hagit/courses/ist/Lectures/Demos/ColorApplet2/t_convert.html
   X:= var_R*0.412453 + var_G*0.357580 + var_B*0.180423;
   Y:= var_R*0.212671 + var_G*0.715160 + var_B*0.072169;
   Z:= var_R*0.019334 + var_G*0.119193 + var_B*0.950227;
end;

end.

