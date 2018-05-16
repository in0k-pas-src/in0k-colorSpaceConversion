unit csc_sRGB_2_Lab;

{$mode objfpc}{$H+}

interface

uses
  cs_types,
  csc_sRGB_2_XYZ,
  csc_XYZ_2_Lab;

procedure sRGB_2_Lab(const sR,sG,sB:t_sRGB_colorComp; out L,a,b:t_Lab_colorComp);

implementation

procedure sRGB_2_Lab(const sR,sG,sB:t_sRGB_colorComp; out L,a,b:t_Lab_colorComp);
var X,Y,Z:t_XYZ_colorComp;
begin
    sRGB_2_XYZ(sR,sG,sB, X,Y,Z);
    XYZ_2_Lab(X,Y,Z, L,a,b);
end;

end.

