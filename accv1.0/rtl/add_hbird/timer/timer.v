`timescale 1ns/1ps
parameter delay_value = 160_000_000;
parameter WIDTH = 16;

module timer (
    input wire clk,
    input wire rst_n,
    output reg done
);


reg [WIDTH-1:0] count_n ;
reg start;


// // Generate a high level signal
// always @(posedge clk or negedge rst_n) begin 
//     if (!rst_n) begin 
//         done <= 0 ;
//         count_n <= 23'b1111_1111_1111_1111_1111_111 ;
//         end
//     else if (count_n != 0) begin
//         count_n <= count_n - 1;
//         end
//     else begin 
//         done <= 1;
//         end
// end

// Generate a pulse
always @(posedge clk or negedge rst_n) begin 
    if (!rst_n) begin 
        done <= 0;
        #delay_value start <= 1 ;
        count_n <= 16'b1111_1111_1111_1111;
        end
    else if( count_n == 0) begin
      done <= 1'b0;
    end
    else if(start && (count_n == 1) && (!done) ) begin
      done <= 1'b1;
      count_n <= count_n - 1;
    end
    else if (start & count_n != 0) begin
        count_n <= count_n - 1;
        end
end

endmodule 