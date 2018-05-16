unit cs_deltaE2000;
{<
//
//
//
//
/}

{$mode objfpc}{$H+}

interface

uses
  math,
  cs_types;

function deltaE2000(const L1,a1,b1:t_Lab_colorComp; const L2,a2,b2:t_Lab_colorComp; whtL,whtC,whtH:t_csIntermediateCalculations):t_csIntermediateCalculations;

implementation

type tCalculations=t_csIntermediateCalculations;

//Function returns CIE-H° value
function CieLab2Hue(const var_a,var_b:tCalculations):tCalculations;
var var_bias:t_csIntermediateCalculations;
begin
    if var_b=0 then begin
        if 0<=var_a then exit(  0)
                    else exit(180);
    end
   else
    if var_a=0 then begin
        if 0< var_b then exit( 90)
                    else exit(270);
    end;
    //
    var_bias:=0;
    if var_a<0 then var_bias:=180
    else begin
        if 0<var_b then var_bias:=000
                   else var_bias:=360;
    end;
    //
    result:= radtodeg( arctan(var_b/var_a) ) + var_bias;
end;



function deltaE2000(const L1,a1,b1:t_Lab_colorComp; const L2,a2,b2:t_Lab_colorComp; whtL,whtC,whtH:t_csIntermediateCalculations):t_csIntermediateCalculations;
var xC1:tCalculations;
    xC2:tCalculations;
    xCX:tCalculations;
    xGX:tCalculations;
    xNN:tCalculations;
    xH1:tCalculations;
    xH2:tCalculations;
    xDL:tCalculations;
    xDC:tCalculations;
    xDH:tCalculations;
    xLX:tCalculations;
    xCY:tCalculations;
    xHX:tCalculations;
    xTX:tCalculations;
    xPH:tCalculations;
    xRC:tCalculations;
    xSL:tCalculations;
    xSC:tCalculations;
    xSH:tCalculations;
    xRT:tCalculations;
begin

    xC1:=sqrt( a1*a1 + b1*b1 );
    xC2:=sqrt( a2*a2 + b2*b2 );
    xCX:=(xC1+xC2)/2;
    xGX:=power(xCX,7);
    xGX:=0.5*( 1 - sqrt(xGX/(xGX+power(25,7))) );
    xNN:=(1+xGX)*a1;
    xC1:=sqrt(xNN*xNN + b1*b1);
    xH1:=CieLab2Hue(xNN,b1);
    xNN:=(1+xGX)*a2;
    xC2:=sqrt(xNN*xNN + b2*b2);
    xH2:=CieLab2Hue(xNN,b2);
    xDL:=L2-L1;
    xDC:=xC2-xC1;
    if (xC1*xC2)=0 then xDH:=0
    else begin
        xNN:=xH2-xH1;//round( xH2 - xH1, 12 )
        if  abs(xNN)<=180 then xDH:=xH2-xH1
        else begin
            if xNN>180 then xDH:=xH2-xH1-360
                       else xDH:=xH2-xH1+360
        end;
    end;
    xDH:= 2 * sqrt(xC1*xC2) * sin(degtorad(xDH/2));
    xLX:=(L1+L2)/2;
    xCY:=(xC1+xC2)/2;
    if (xC1*xC2)=0 then xHX:=xH1+xH2
    else begin
        xNN:=abs(xH1-xH2);// abs( round( xH1 - xH2, 12 ) )
        if 180<xNN then begin
            if (xH2+xH1)<360 then xHX:=xH1+xH2+360
                             else xHX:=xH1+xH2-360;
        end
        else xHX:=xH1+xH2;
        xHX:=xHX/2;
    end;
    //
    xTX:= 1 - 0.17 * cos( degtorad( xHX - 30 ) )
            + 0.24 * cos( degtorad( 2 * xHX ) )
            + 0.32 * cos( degtorad( 3 * xHX + 6 ) )
            - 0.20 * cos( degtorad( 4 * xHX - 63 ) );
    xPH:= 30 * exp( - ( ( xHX  - 275 ) / 25 ) * ( ( xHX  - 275 ) / 25 ) );
    xRC:= 2 * sqrt( power(xCY,7) / ( power(xCY,7) + power( 25,7 ) ) );
    xSL:= 1 + ( ( 0.015 * ( ( xLX - 50 ) * ( xLX - 50 ) ) ) / sqrt( 20 + ( ( xLX - 50 ) * ( xLX - 50 ) ) ) );
    xSC:= 1 + 0.045 * xCY;
    xSH:= 1 + 0.015 * xCY * xTX;
    xRT:= - sin( degtorad( 2 * xPH ) ) * xRC;
    xDL:= xDL / (whtL * xSL );
    xDC:= xDC / (whtC * xSC );
    xDH:= xDH / (whth * xSH );
    //----------
    RESULT:= sqrt( sqr(xDL) + sqr(xDC) + sqr(xDH) + xRT * xDC * xDH )

end;

end.

