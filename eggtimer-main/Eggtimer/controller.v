module controller(
    input clk,
    input rst,
    input beginn, 
    input reset,
    input zero,
    input endd,
    output load,
    output start,
    output countdown
    );
    
    // write your code here
    
    reg [1:0] state; //"0" as "PAUSE" state, "1" as "COUNT" state and "2" as "START" state

    assign countdown = (endd && ~start && state != 0);
    assign start = (state == 2 && state != 0);
    assign load = reset;

    always @(posedge clk, negedge rst)
    begin
    	if (~rst) state <= 0;
    	else
        begin 
     	   if(reset) state <= 0;
    	   else
           begin
             if(state == 0)
             begin
           	if(beginn) 
                begin
                	if(~zero) state <= 2;
                        else state <= 0;
                end  
             end
             else 
             begin
                if(endd) 
                begin
                	if(~zero) state <= 2;
                        else state <= 0;
                end  
                else 
                begin
                	if(~zero) state <= 1;
                        else state <= 0;
                end
              end
           end
        end
    end //always

endmodule