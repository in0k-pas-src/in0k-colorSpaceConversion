unit csc_HSV_2_sRGB;

{$mode objfpc}{$H+}

interface

uses
  math,
  cs_types;

procedure HSV_2_sRGB(const H,S,V:t_HSV_colorComp; out sR,sG,sB:t_sRGB_colorComp);

implementation

type tCalculations=t_csIntermediateCalculations;

//H, S and V input range = 0 ÷ 1.0
//R, G and B output range = 0 ÷ 255

procedure HSV_2_sRGB(const H,S,V:t_HSV_colorComp; out sR,sG,sB:t_sRGB_colorComp);
var var_h:tCalculations;
    var_i:tCalculations;
    var_1:tCalculations;
    var_2:tCalculations;
    var_3:tCalculations;
begin
    if S=0 then begin
        sR:=round(V*255);
        sG:=round(V*255);
        sB:=round(V*255);
    end
    else begin
        var_h:=H*6;
        if var_h=6 then var_h:=0; // H must be < 1
        var_i:=trunc(var_h); // int( var_h ) //Or ... var_i = floor( var_h )
        var_1:=V * (1-S);
        var_2:=V * (1 - S*(var_h-var_i) );
        var_3:=V * (1 - S*( 1 - (var_h-var_i)) );
        //
        case var_i of
            0:  begin var_r:=    V; var_g:=var_3; var_b:=var_1; end;
            1:  begin var_r:=var_2; var_g:=    V; var_b:=var_1; end;
            2:  begin var_r:=var_1; var_g:=    V; var_b:=var_3; end;
            3:  begin var_r:=var_1; var_g:=var_2; var_b:=    V; end;
            4:  begin var_r:=var_3; var_g:=var_1; var_b:=    V; end;
           else begin var_r:=    V; var_g:=var_1; var_b:=var_2; end;
        end;
        //
        sR:=round(var_r*255);
        sG:=round(var_g*255);
        sB:=round(var_b*255);
    end;
end;

end.

