`timescale 1ns / 1ps

module KeyFSM(input clk, C, A, E,
              output logic B, G, F, D, press,
              output logic [3:0] data
              );
                       
      typedef enum {STATE_B, STATE_G, STATE_F, STATE_D} STATE;
      STATE NS, PS = STATE_B;
                  
      always_ff @ (posedge clk)
         begin
           PS <= NS;
         end
              
      always_comb      
      begin
      case(PS)
      STATE_B:
        begin
          if(C == 1)
            begin
              data = 1;
              press = 1;
            end
          else if(A == 1)
            begin
              data = 2;
              press = 1;
            end
          else if(E == 1)
            begin
              data = 3;
              press = 1;
            end
          else 
            begin
              data = 13;
              press = 0;
            end
        begin      
        B = 1; G =0; F = 0; D = 0;
        NS = STATE_G;
        end 
        end
      STATE_G:
        begin
          if(C == 1)
            begin
              data = 4;
              press = 1;
            end
          else if(A == 1)
            begin
              data = 5;
              press = 1;
            end
          else if(E == 1)
            begin
              data = 6;
              press = 1;
            end
          else 
            begin
              data = 12;
              press = 0;
            end
          begin
            B = 0; G = 1; F = 0; D = 0;
            NS = STATE_F;
          end  
        end
      STATE_F:
        begin
          if(C == 1)
            begin
              data = 7;
              press = 1;
            end
          else if(A == 1)
            begin
              data = 8;
              press = 1;
            end
          else if(E == 1)
            begin
              data = 9;
              press = 1;
            end
          else 
            begin
               data = 14;
               press = 0;
            end
          begin
            B = 0; G = 0; F = 1; D = 0;
            NS = STATE_D;
          end  
        end
      STATE_D:
        begin
          if(C == 1)
            begin
              data = 10;
              press = 1;
            end
          else if(A == 1)
            begin
              data = 0;
              press = 1;
            end
          else if(E == 1)
            begin
              data = 11;
              press = 1;
            end
          else 
            begin
              data = 15;
              press = 0;
            end
          begin
            B = 0; G = 0; F = 0; D = 1;
            NS = STATE_B;
          end  
        end
      default: NS = STATE_B;
      endcase
      end  
    
endmodule