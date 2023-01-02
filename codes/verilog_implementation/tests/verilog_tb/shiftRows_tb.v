`include "verilog_implementation/src/shiftRows/shiftRows.v"
// module shiftRows_tb;
// reg [3:0][3:0][7:0]in;
// wire [3:0][3:0][7:0]out;
// shiftRows shiftRows1(in,out);
// initial begin
//     in[0][0]=8'h00;
//     in[0][1]=8'h11;
//     in[0][2]=8'h22;
//     in[0][3]=8'h33;
//     in[1][0]=8'h44;
//     in[1][1]=8'h55;
//     in[1][2]=8'h66;
//     in[1][3]=8'h77;
//     in[2][0]=8'h88;
//     in[2][1]=8'h99;
//     in[2][2]=8'haa;
//     in[2][3]=8'hbb;
//     in[3][0]=8'hcc;
//     in[3][1]=8'hdd;
//     in[3][2]=8'hee;
//     in[3][3]=8'hff;
//     #10;
//     //display the input and output in 3x3 matrix form
//     $display("input matrix");
//     $display("%h %h %h %h",in[0][0],in[0][1],in[0][2],in[0][3]);
//     $display("%h %h %h %h",in[1][0],in[1][1],in[1][2],in[1][3]);
//     $display("%h %h %h %h",in[2][0],in[2][1],in[2][2],in[2][3]);
//     $display("%h %h %h %h",in[3][0],in[3][1],in[3][2],in[3][3]);
//     $display("\n\noutput matrix");
//     $display("%h %h %h %h",out[0][0],out[0][1],out[0][2],out[0][3]);
//     $display("%h %h %h %h",out[1][0],out[1][1],out[1][2],out[1][3]);
//     $display("%h %h %h %h",out[2][0],out[2][1],out[2][2],out[2][3]);
//     $display("%h %h %h %h",out[3][0],out[3][1],out[3][2],out[3][3]);
// end
// endmodule

module shiftRows_1_tb;
reg [127:0]in;
wire [127:0]out;
shiftRows_1 shiftRows1(in,out);
initial begin
    in[7:0]=8'h00;
    in[15:8]=8'h11;
    in[23:16]=8'h22;
    in[31:24]=8'h33;
    in[39:32]=8'h44;
    in[47:40]=8'h55;
    in[55:48]=8'h66;
    in[63:56]=8'h77;
    in[71:64]=8'h88;
    in[79:72]=8'h99;
    in[87:80]=8'haa;
    in[95:88]=8'hbb;
    in[103:96]=8'hcc;
    in[111:104]=8'hdd;
    in[119:112]=8'hee;
    in[127:120]=8'hff;
    #10;
    //display the input and output in 3x3 matrix form
    $display("input matrix 1");
    $display("%h %h %h %h",in[7:0],in[15:8],in[23:16],in[31:24]);
    $display("%h %h %h %h",in[39:32],in[47:40],in[55:48],in[63:56]);
    $display("%h %h %h %h",in[71:64],in[79:72],in[87:80],in[95:88]);
    $display("%h %h %h %h",in[103:96],in[111:104],in[119:112],in[127:120]);
    $display("\n\noutput matrix 1");
    $display("%h %h %h %h",out[7:0],out[15:8],out[23:16],out[31:24]);
    $display("%h %h %h %h",out[39:32],out[47:40],out[55:48],out[63:56]);
    $display("%h %h %h %h",out[71:64],out[79:72],out[87:80],out[95:88]);
    $display("%h %h %h %h",out[103:96],out[111:104],out[119:112],out[127:120]);
end
endmodule
