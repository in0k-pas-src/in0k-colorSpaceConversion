unit cs_types;

{$mode objfpc}{$H+}

interface

type

  t_csIntermediateCalculations=single;

  t_sRGB_colorComp=byte;
  t_XYZ_colorComp =single;
  t_Lab_colorComp =single;
  t_HSV_colorComp =single;



function test__HSV_colorComp__H(const H:t_HSV_colorComp):boolean;
function test__HSV_colorComp__S(const S:t_HSV_colorComp):boolean;
function test__HSV_colorComp__V(const V:t_HSV_colorComp):boolean;

implementation

function test__HSV_colorComp__H(const H:t_HSV_colorComp):boolean;
begin
    result:=(0<=H)and(H<=1);
end;

function test__HSV_colorComp__S(const S:t_HSV_colorComp):boolean;
begin
    result:=(0<=S)and(S<=1);
end;

function test__HSV_colorComp__V(const V:t_HSV_colorComp):boolean;
begin
    result:=(0<=V)and(V<=1);
end;


end.

