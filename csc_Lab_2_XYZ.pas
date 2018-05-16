unit csc_Lab_2_XYZ;

{$mode objfpc}{$H+}

interface

uses
  math,
  cs_types,
  cs_consts;

procedure Lab_2_XYZ(const L,a,b:t_Lab_colorComp; out X,Y,Z:t_XYZ_colorComp);

implementation



  //Reference-X, Y and Z refer to specific illuminants and observers.
  //Common reference values are available below in this same page.


{
  http://www.easyrgb.com/en/math.php
  //------------------------------------------

  var_Y = ( CIE-L* + 16 ) / 116
  var_X = CIE-a* / 500 + var_Y
  var_Z = var_Y - CIE-b* / 200

  if ( var_Y^3  > 0.008856 ) var_Y = var_Y^3
  else                       var_Y = ( var_Y - 16 / 116 ) / 7.787
  if ( var_X^3  > 0.008856 ) var_X = var_X^3
  else                       var_X = ( var_X - 16 / 116 ) / 7.787
  if ( var_Z^3  > 0.008856 ) var_Z = var_Z^3
  else                       var_Z = ( var_Z - 16 / 116 ) / 7.787

  X = var_X * Reference-X
  Y = var_Y * Reference-Y
  Z = var_Z * Reference-Z

  //------------------------------------------
}

type tCalc=t_csIntermediateCalculations;

const // D65 2° (CIE 1931) http://www.easyrgb.com/en/math.php
  cRefX=cRefD65X2;
  cRefY=cRefD65Y2;
  cRefZ=cRefD65Z2;

function _magik01_(const value:tCalc):tCalc; inline;
begin
    result:=power(value,3);
    if result <= 0.008856
    then result:=( value - 16/116 ) / 7.787;
end;

procedure Lab_2_XYZ(const L,a,b:t_Lab_colorComp; out X,Y,Z:t_XYZ_colorComp);
var var_Y:tCalc;
begin
    var_Y:=(L+16)/116;
    //
    X:=cRefX*_magik01_(a/500 + var_Y);
    Y:=cRefY*_magik01_(var_Y);
    Z:=cRefZ*_magik01_(var_Y - b/200);
end;


end.

