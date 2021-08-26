 /*                                                                      
 Copyright 2018 Nuclei System Technology, Inc.                
                                                                         
 Licensed under the Apache License, Version 2.0 (the "License");         
 you may not use this file except in compliance with the License.        
 You may obtain a copy of the License at                                 
                                                                         
     http://www.apache.org/licenses/LICENSE-2.0                          
                                                                         
  Unless required by applicable law or agreed to in writing, software    
 distributed under the License is distributed on an "AS IS" BASIS,       
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and     
 limitations under the License.                                          
 */                                                                      
                                                                         
                                                                         
                                                                         
//=====================================================================
// Designer   : Bob Hu
//
// Description:
//  The ITCM-SRAM module to implement ITCM SRAM
//
// ====================================================================

`include "e203_defines.v"

  `ifdef E203_HAS_ITCM //{
module e203_itcm_ram(

  input                              sd,
  input                              ds,
  input                              ls,

  input                              cs,  
  input                              we,  
  input  [`E203_ITCM_RAM_AW-1:0] addr, 
  input  [`E203_ITCM_RAM_MW-1:0] wem,
  input  [`E203_ITCM_RAM_DW-1:0] din,          
  output [`E203_ITCM_RAM_DW-1:0] dout,
  input                              rst_n,
  input                              clk

);

  //translate e203's wem signal to SMIC28 SRAM's WEN signal
  wire[`E203_ITCM_RAM_MW*8-1:0] WEN;
  genvar i;
  generate
    for(i=0; i<`E203_ITCM_RAM_MW; i=i+1) begin: gen_WEN
      assign WEN[7+i*8 : i*8] = {8{~wem[i]}};
    end
  endgenerate

  itcm_ram u_itcm_ram(
    .Q      (dout       ),
    .CEN    (~cs        ),    
    .WEN    (WEN        ),  
    .A      (addr       ),
    .D      (din        ),  
    .EMA    (`SRAM_EMA  ), //must set according to VDDCE/VDDPE    
    .EMAW   (`SRAM_EMAW ), //must set according to VDDCE/VDDPE   
    .EMAS   (`SRAM_EMAS ), //must set according to VDDCE/VDDPE 
    .GWEN   (~we        ),  
    .RET1N  (1'b1       ),  
    .CLK    (clk        )
  );

  // sirv_itcm_ram #(
  //     `ifndef E203_HAS_ECC//{
  //   .FORCE_X2ZERO(0),
  //     `endif//}
  //   .DP(`E203_ITCM_RAM_DP),
  //   .DW(`E203_ITCM_RAM_DW),
  //   .MW(`E203_ITCM_RAM_MW),
  //   .AW(`E203_ITCM_RAM_AW) 
  // ) u_e203_itcm_gnrl_ram(
  // .sd  (sd  ),
  // .ds  (ds  ),
  // .ls  (ls  ),
  // .rst_n (rst_n ),
  // .clk (clk ),
  // .cs  (cs  ),
  // .we  (we  ),
  // .addr(addr),
  // .din (din ),
  // .wem (wem ),
  // .dout(dout)
  // );
                                                      
endmodule
  `endif//}
