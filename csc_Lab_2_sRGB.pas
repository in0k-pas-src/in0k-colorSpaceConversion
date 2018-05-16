unit csc_Lab_2_sRGB;

{$mode objfpc}{$H+}

interface

uses
  cs_types,
  csc_Lab_2_XYZ,
  csc_XYZ_2_sRGB;

procedure Lab_2_sRGB(const L,a,b:t_Lab_colorComp; out sR,sG,sB:t_sRGB_colorComp);

implementation

procedure Lab_2_sRGB(const L,a,b:t_Lab_colorComp; out sR,sG,sB:t_sRGB_colorComp);
var X,Y,Z:t_XYZ_colorComp;
begin
    Lab_2_XYZ(L,a,b, X,Y,Z);
    XYZ_2_sRGB(X,Y,Z, sR,sG,sB);
end;

end.

