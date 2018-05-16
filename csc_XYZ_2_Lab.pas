unit csc_XYZ_2_Lab;

{$mode objfpc}{$H+}

interface

uses
  math,
  cs_types,
  cs_consts;

procedure XYZ_2_Lab(const X,Y,Z:t_XYZ_colorComp; out L,a,b:t_Lab_colorComp);

implementation


{

//Reference-X, Y and Z refer to specific illuminants and observers.
//Common reference values are available below in this same page.

var_X = X / Reference-X
var_Y = Y / Reference-Y
var_Z = Z / Reference-Z

if ( var_X > 0.008856 ) var_X = var_X ^ ( 1/3 )
else                    var_X = ( 7.787 * var_X ) + ( 16 / 116 )
if ( var_Y > 0.008856 ) var_Y = var_Y ^ ( 1/3 )
else                    var_Y = ( 7.787 * var_Y ) + ( 16 / 116 )
if ( var_Z > 0.008856 ) var_Z = var_Z ^ ( 1/3 )
else                    var_Z = ( 7.787 * var_Z ) + ( 16 / 116 )

CIE-L* = ( 116 * var_Y ) - 16
CIE-a* = 500 * ( var_X - var_Y )
CIE-b* = 200 * ( var_Y - var_Z )

}


type tCalc=t_csIntermediateCalculations;

const // D65 2° (CIE 1931) http://www.easyrgb.com/en/math.php
  cRefX=cRefD65X2;
  cRefY=cRefD65Y2;
  cRefZ=cRefD65Z2;

function _magik01_(const value:tCalc):tCalc; inline;
begin
    if 0.008856<value
    then result:=power(value , 1/3)
    else result:=(7.787*value) + (16/116);
end;

procedure XYZ_2_Lab(const X,Y,Z:t_XYZ_colorComp; out L,a,b:t_Lab_colorComp);
var var_X:tCalc;
    var_Y:tCalc;
    var_Z:tCalc;
begin
    var_X:=_magik01_(X/cRefX);
    var_Y:=_magik01_(Y/cRefY);
    var_Z:=_magik01_(Z/cRefZ);
    //---
    L:= ( 116*var_Y ) - 16;
    a:= 500 * ( var_X - var_Y );
    b:= 200 * ( var_Y - var_Z );
end;

end.

