unit csc_XYZ_2_Lab;

{$mode objfpc}{$H+}

interface

uses
  math,
  cs_types,
  cs_consts;

procedure XYZ_2_Lab(const X,Y,Z:t_XYZ_colorComp; out L,a,b:t_Lab_colorComp);

implementation

type tCalculations=t_csIntermediateCalculations;

const // D65 2° (CIE 1931) http://www.easyrgb.com/en/math.php
  c_refX=cRefD65X2;
  c_refY=cRefD65Y2;
  c_refZ=cRefD65Z2;


procedure XYZ_2_Lab(const X,Y,Z:t_XYZ_colorComp; out L,a,b:t_Lab_colorComp);
var var_X:tCalculations;
    var_Y:tCalculations;
    var_Z:tCalculations;
begin
    var_X:=X/c_refX;
    var_Y:=Y/c_refY;
    var_Z:=Z/c_refZ;

    if 0.008856<var_X then var_X:= power(var_X , 1/3)
                      else var_X:=(7.787*var_X) + (16/116);
    if 0.008856<var_Y then var_Y:= power(var_Y , 1/3)
                      else var_Y:=(7.787*var_Y) + (16/116);
    if 0.008856<var_Z then var_Z:= power(var_Z , 1/3)
                      else var_Z:=(7.787*var_Z) + (16/116);

    L:= ( 116*var_Y ) - 16;
    a:= 500 * ( var_X - var_Y );
    b:= 200 * ( var_Y - var_Z );
end;

end.

