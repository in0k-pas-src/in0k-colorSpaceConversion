unit csc_sRGB_2_HSV;

{$mode objfpc}{$H+}

interface

uses
  math,
  cs_types;

procedure sRGB_2_HSV(const sR,sG,sB:t_sRGB_colorComp; out H,S,V:t_HSV_colorComp);

implementation

type tCalculations=t_csIntermediateCalculations;

procedure sRGB_2_HSV(const sR,sG,sB:t_sRGB_colorComp; out H,S,V:t_HSV_colorComp);
var var_R:tCalculations;
    var_G:tCalculations;
    var_B:tCalculations;
  var_Min:tCalculations;
  var_Max:tCalculations;
  del_Max:tCalculations;
    del_R:tCalculations;
    del_G:tCalculations;
    del_B:tCalculations;
begin
    var_R:=sR/255;
    var_G:=sG/255;
    var_B:=sB/255;
    //
    var_Min:=min( min(var_R,var_G), var_B); //Min. value of RGB
    var_Max:=max( max(var_R,var_G), var_B); //Max. value of RGB
    del_Max:=var_Max-var_Min;               //Delta RGB value
    //
    V:=var_Max;
    //
    if IsZero(del_Max) then begin //This is a gray, no chroma...
        H:=0;
        S:=0;
    end
    else begin //Chromatic data...
        S:=del_Max/var_Max;
        //
        del_R:= ( ( ( var_Max - var_R ) / 6 ) + ( del_Max / 2 ) ) / del_Max;
        del_G:= ( ( ( var_Max - var_G ) / 6 ) + ( del_Max / 2 ) ) / del_Max;
        del_B:= ( ( ( var_Max - var_B ) / 6 ) + ( del_Max / 2 ) ) / del_Max;
        //
        if (var_R=var_Max) then H:=    del_B-del_G
       else
        if (var_G=var_Max) then H:=1/3+del_R-del_B
       else
        if (var_B=var_Max) then H:=2/3+del_G-del_R;
        //
        if H<0 then H:=H+1;
        if H>1 then H:=H-1;
    end
end;

end.

