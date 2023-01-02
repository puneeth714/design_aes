//implementation of the shiftRows function in verilog
//input: 4x4 matrix of 8-bit words
//output: 4x4 matrix of 8-bit words
//functional discription : shifting of the rows of the matrix by 0,1,2,3 positions cyclically to the left respectively

module shiftRows(in,out);
// Here the data is defined in single dimension
input [127:0]in;
output [127:0]out;
assign out[7:0]=in[7:0];
assign out[15:8]=in[15:8];
assign out[23:16]=in[23:16];
assign out[31:24]=in[31:24];
assign out[39:32]=in[47:40];
assign out[47:40]=in[55:48];
assign out[55:48]=in[63:56];
assign out[63:56]=in[39:32];
assign out[71:64]=in[87:80];
assign out[79:72]=in[95:88];
assign out[87:80]=in[71:64];
assign out[95:88]=in[79:72];
assign out[103:96]=in[119:112];
assign out[111:104]=in[127:120];
assign out[119:112]=in[103:96];
assign out[127:120]=in[111:104];
endmodule

// module shiftRows(in,out);

// // input [7:0]in[3:0][3:0];
// // output [7:0]out[3:0][3:0];
// //packed input and output
// input [3:0][3:0][7:0]in;
// output [3:0][3:0][7:0]out;
// //assign values to out
// assign out[0][0]=in[0][0];
// assign out[0][1]=in[0][1];
// assign out[0][2]=in[0][2];
// assign out[0][3]=in[0][3];
// assign out[1][0]=in[1][1];
// assign out[1][1]=in[1][2];
// assign out[1][2]=in[1][3];
// assign out[1][3]=in[1][0];
// assign out[2][0]=in[2][2];
// assign out[2][1]=in[2][3];
// assign out[2][2]=in[2][0];
// assign out[2][3]=in[2][1];
// assign out[3][0]=in[3][3];
// assign out[3][1]=in[3][0];
// assign out[3][2]=in[3][1];
// assign out[3][3]=in[3][2];
// endmodule