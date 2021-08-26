`include "e203_defines.v"

module multiplication_top(
    input                          mul_icb_cmd_valid,
    output                         mul_icb_cmd_ready,
    input  [`E203_ADDR_SIZE-1:0]   mul_icb_cmd_addr, 
    input                          mul_icb_cmd_read, 
    input  [`E203_XLEN-1:0]        mul_icb_cmd_wdata,
    
    output                         mul_icb_rsp_valid,
    input                          mul_icb_rsp_ready,
    output reg[32-1:0]             mul_icb_rsp_rdata,
    output reg                     mul_icb_rsp_err,

    input                           clk,
    input                           rst_n
    );

reg [31:0]                         mul_a;
reg [31:0]                         mul_b;
wire                               exception, overflow, underflow;
wire [31:0]                        res;

reg [31:0]                         mid_a ;
reg [31:0]                         mid_b ;
reg [1:0]                          cnter  ;

parameter A_ADDR = 32'h1100_2000 ;
parameter B_ADDR = 32'h1100_2004 ;
parameter RES_ADDR = 32'h1100_2008 ; 

/* write multiplicand and multiplier to mul_a and mul_b */
reg                           rsp_valid1;
always @(posedge clk or negedge rst_n)
begin 
    if (!rst_n) begin
        cnter <= 2'd0 ;
        rsp_valid1 <= 0;
        mul_a[31:0] <= 32'b0;
        mul_b[31:0] <= 32'b0;
    end
    else if (cnter == 2'd2 ) begin
        cnter <= 2'd0;
    end
    else if (mul_icb_cmd_valid & !mul_icb_cmd_read) begin
        case (mul_icb_cmd_addr)
            A_ADDR:  begin mid_a <= mul_icb_cmd_wdata;  rsp_valid1 <= 1; cnter <= cnter + 2'd1; end
            B_ADDR:  begin mid_b <= mul_icb_cmd_wdata;  rsp_valid1 <= 1; cnter <= cnter + 2'd1; end
            default: begin mid_a <= 32'b0; mid_b <= 32'b0 ;  end 
        endcase
    end
    else begin rsp_valid1 <= 0; end
end

always @(posedge clk)
begin 
    if (cnter == 2'd2 ) begin 
      mul_a <= mid_a;
      mul_b <= mid_b;
    end
end

/* read the result out */
reg                          rsp_valid2;
always @(*) begin
    rsp_valid2 = 0;
    if( mul_icb_cmd_valid & mul_icb_cmd_read ) begin
        case (mul_icb_cmd_addr)
            RES_ADDR:   begin 
                            mul_icb_rsp_rdata = res;
                            rsp_valid2 = 1;
                            mul_icb_rsp_err =  ((exception || overflow) || underflow);
                        end
            default:    begin  
                            mul_icb_rsp_rdata = 32'b0;
                            rsp_valid2 = 0;
                            mul_icb_rsp_err = 1;
                        end
        endcase
    end
    else begin 
        rsp_valid2 = 0;
        mul_icb_rsp_rdata = 32'b0; 
        mul_icb_rsp_err =0;
    end
end

// always @(posedge clk) begin
//     rsp_valid2 <= 0;
//     if( mul_icb_cmd_valid & mul_icb_cmd_read ) begin
//         case (mul_icb_cmd_addr)
//             RES_ADDR:   begin 
//                             mul_icb_rsp_rdata <= res;
//                             rsp_valid2 <= 1;
//                             mul_icb_rsp_err <= ((exception || overflow) || underflow);
//                         end
//             default:    begin  
//                             mul_icb_rsp_rdata <= 32'b0;
//                             rsp_valid2 <= 0;
//                             mul_icb_rsp_err <= 1;
//                         end
//         endcase
//     end
//     else begin 
//         rsp_valid2 <= 0;
//         mul_icb_rsp_rdata <= 32'b0; 
//         mul_icb_rsp_err <= 0;
//     end
// end

assign mul_icb_rsp_valid = rsp_valid1 || rsp_valid2 ;
assign mul_icb_cmd_ready = mul_icb_rsp_valid && mul_icb_rsp_ready ;

multiplication u_multiplication (
    .a          (mul_a),
    .b          (mul_b),
    .exception  (exception),
    .overflow   (overflow),
    .underflow  (underflow),
    .res        (res)
);

endmodule

