unit csc_XYZ_2_sRGB;

{$mode objfpc}{$H+}

interface

uses
  math,
  cs_types;

procedure XYZ_2_sRGB(const X,Y,Z:t_XYZ_colorComp; out sR,sG,sB:t_sRGB_colorComp);

implementation

type tCalculations=t_csIntermediateCalculations;

procedure XYZ_2_sRGB(const X,Y,Z:t_XYZ_colorComp; out sR,sG,sB:t_sRGB_colorComp);
var var_X:tCalculations;
    var_Y:tCalculations;
    var_Z:tCalculations;
var var_R:tCalculations;
    var_G:tCalculations;
    var_B:tCalculations;
begin
   var_X:=X/100;
   var_Y:=Y/100;
   var_Z:=Z/100;

   // предложенное с
   // http://www.easyrgb.com/en/math.php
   //var_R:= var_X* 3.2406 + var_Y*-1.5372 + var_Z*-0.4986;
   //var_G:= var_X*-0.9689 + var_Y* 1.8758 + var_Z*0.0415 ;
   //var_B:= var_X* 0.0557 + var_Y*-0.2040 + var_Z*1.0570 ;

   // более "точные" значения констант
   // http://cs.haifa.ac.il/hagit/courses/ist/Lectures/Demos/ColorApplet2/t_convert.html
   var_R:= var_X*3.240479 -var_Y*1.537150 -var_Z*0.498535;
   var_G:=-var_X*0.969256 +var_Y*1.875992 +var_Z*0.041556;
   var_B:= var_X*0.055648 -var_Y*0.204043 +var_Z*1.057311;

   if 0.0031308<var_R then var_R:=1.055*power(var_R, 1/2.4) - 0.055
                      else var_R:=12.92*var_R;
   if 0.0031308<var_G then var_G:=1.055*power(var_G, 1/2.4) - 0.055
                      else var_G:=12.92*var_G;
   if 0.0031308<var_B then var_B:=1.055*power(var_B, 1/2.4) - 0.055
                      else var_B:=12.92*var_B;

   sR:= round( var_R*255 );
   sG:= round( var_G*255 );
   sB:= round( var_B*255 );
end;

end.

