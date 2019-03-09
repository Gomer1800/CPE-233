`timescale 1ns / 1ps

module IntFSM(
    input clk, press,
    output logic interrupt
              );
           
    typedef enum {ST0, ST1, ST2, ST3, ST4, ST5, ST6, ST7} STATE;
    STATE NS, PS = ST0;
    
     always_ff @ (posedge clk)
       begin
           PS <= NS;
       end

     always_comb
        begin
        interrupt = 0 ;
         case(PS)
          ST0: 
            begin
              if (press == 0) 
              begin
                interrupt = 0;
                NS = ST0;
              end
              else
                NS = ST1;
            end
          ST1:
            begin
              if(press == 1)
                interrupt = 1;
                NS = ST2;
            end 
          ST2:
            begin
              if(press == 1)
                interrupt = 1;
                NS = ST3;
            end 
          ST3:
            begin
              if(press == 1)
                interrupt = 1;
                NS = ST4;
            end 
          ST4:
            begin
              if(press == 1)
                interrupt = 1;
                NS = ST5;
            end 
          ST5:
            begin
              if(press == 1)
                interrupt = 1;
                NS = ST6;
            end 
          ST6:
            begin
             if(press == 1)
               interrupt = 1;
               NS = ST7;
            end 
          ST7:
            begin
              if(press == 1)
              begin
                interrupt = 0;
                NS = ST7;
              end
              else
                NS = ST0;
            end     
            default: NS = ST0;
            endcase
        end
   
endmodule