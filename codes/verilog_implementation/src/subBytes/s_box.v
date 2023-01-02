// First Multiplication of the two polynomials(bins)
// Inputs : a,b
// Outputs : c
// parameters : WIDTH
//description : THis design takes two numbers as inputs and thier widhth is determined by WIDTH 
//The result is stored in c widhth of c is 2*WIDTH,use modulous two decrease the power of the result
module galois_multiplication #(parameter WIDTH = 8)  (a,b,c);
input [WIDTH-1:0] a,b;
output [2*(WIDTH-1):0] c;
assign c[0] = a[0] & b[0];
assign c[1] = a[0] & b[1] ^ a[1] & b[0];
assign c[2] = a[0] & b[2] ^ a[1] & b[1] ^ a[2] & b[0];
assign c[3] = a[0] & b[3] ^ a[1] & b[2] ^ a[2] & b[1] ^ a[3] & b[0];
assign c[4] = a[0] & b[4] ^ a[1] & b[3] ^ a[2] & b[2] ^ a[3] & b[1] ^ a[4] & b[0];
assign c[5] = a[0] & b[5] ^ a[1] & b[4] ^ a[2] & b[3] ^ a[3] & b[2] ^ a[4] & b[1] ^ a[5] & b[0];
assign c[6] = a[0] & b[6] ^ a[1] & b[5] ^ a[2] & b[4] ^ a[3] & b[3] ^ a[4] & b[2] ^ a[5] & b[1] ^ a[6] & b[0];
assign c[7] = a[0] & b[7] ^ a[1] & b[6] ^ a[2] & b[5] ^ a[3] & b[4] ^ a[4] & b[3] ^ a[5] & b[2] ^ a[6] & b[1] ^ a[7] & b[0];
assign c[8] = a[1] & b[7] ^ a[2] & b[6] ^ a[3] & b[5] ^ a[4] & b[4] ^ a[5] & b[3] ^ a[6] & b[2] ^ a[7] & b[1];
assign c[9] = a[2] & b[7] ^ a[3] & b[6] ^ a[4] & b[5] ^ a[5] & b[4] ^ a[6] & b[3] ^ a[7] & b[2];
assign c[10] = a[3] & b[7] ^ a[4] & b[6] ^ a[5] & b[5] ^ a[6] & b[4] ^ a[7] & b[3];
assign c[11] = a[4] & b[7] ^ a[5] & b[6] ^ a[6] & b[5] ^ a[7] & b[4];
assign c[12] = a[5] & b[7] ^ a[6] & b[6] ^ a[7] & b[5];
assign c[13] = a[6] & b[7] ^ a[7] & b[6];
assign c[14] = a[7] & b[7];
endmodule

module galois_multiplication_modulous #(parameter WIDTH = 8) (cin,cout);
input  [2*(WIDTH-1):0] cin;
output  reg [7:0] cout;
reg [2*(WIDTH-1):0] keep_on;
reg [3:0]place;
reg done=1;
reg a=0;
always @(cin)
begin:find_place
    if (done==1)
    begin
        keep_on=cin;
        done=0;
    end
end

always @(keep_on)
begin:keep_it
    reg [3:0]i;
    reg set;
    set=0;
    //$display("keepon %b",keep_on);
    //when cin changes find the place and store in place
    for(i=(2*(WIDTH-1));i>0;i=i-1)
    begin:loop_for_place
        //check if that bit is 1 or not
        if(((1<<i) & keep_on)!=0 && set ==0 && done == 0)
        begin:condition_place
        //$display(i);
            //if so set it to place
            if(i<8)
            begin:if_done
                done=1;
            end
            place=i;
            set=1;
            //set i to 0 so it will not run again
        end
    end
end

always @(place)
begin:divison_do
    //whenever place is changed do the division after checking done
    //$display("done1 %d",keep_on);
    if(done!=1)
    begin:divide
        //keep_on = (keep_on ^ (283 <<(place-8)));
		  a=1;
    //$display("done %d",keep_on);
    end
    
end

always @(*)
begin
        cout=keep_on;
end
endmodule

//Name: galois_division
//Inputs: cin,place
//Outputs: cout
//Description: This module is used to divide the cin by 283 a irreducible polynomial
module galois_division #(parameter WIDTH = 8) (cin,place,cout);
input  [2*(WIDTH-1):0] cin;
input [3:0]place;
output [2*(WIDTH-1):0] cout;
        //keep_on = (keep_on ^ (283 <<(place-8)));
    // always @(*)
    // begin
    //     // display each process of calculation
    //     $display("place %d",place);
    //     $display("cin %d",cin);
    //     $display("283 <<(place-8) %b",(283 <<(place-9)));
    //     $display("cin ^ (283 <<(place-8)) %b",(cin ^ (283 <<(place-9))));
        
    // end
assign cout = (place>8)?(cin ^ (283 <<(place-9))):cin;
endmodule


//Name: galois_division_2
//Inputs: cin
//Outputs: cout
//Description: This module is used to divide the cin by 283 a irreducible polynomial and return the cout
//Here we are using continous assignment
module galois_division_2 #(parameter WIDTH = 8) (cin,cout);
input  [2*(WIDTH-1):0] cin;
output cout;
wire d0,d1,d2,d3,d4,d5,d6,d7;
assign d7=cin[7] ^ cin[11] ^ cin[12] ^ cin[14];
assign d6=cin[6] ^ cin[10] ^ cin[11] ^ cin[13];
assign d5=cin[5] ^ cin[9] ^ cin[10] ^ cin[12];
assign d4=cin[4] ^ cin[8] ^ cin[9] ^ cin[11] ^ cin[14];
assign d3=cin[3] ^ cin[8] ^ cin[10] ^ cin[11] ^ cin[12] ^ cin[13] ^ cin[14];
assign d2=cin[2] ^ cin[9] ^ cin[10] ^ cin[13];
assign d1=cin[1] ^ cin[8] ^ cin[9] ^ cin[12] ^ cin[14];
assign d0=cin[0] ^ cin[8] ^ cin[12] ^ cin[13];
assign cout = (~(d7 | d6 | d5 | d4 | d3 | d2 | d1 ) & d0);    
endmodule


//Name: find_place
//Inputs: cin
//Outputs: place_out
//Description: This module is used to find the place of the first 1 in the cin
module find_place #(parameter WIDTH = 8) (cin,place_out);
input  [2*(WIDTH-1):0] cin;
output reg [3:0]place_out;
always @(cin)
begin:find_place
    reg [3:0]i;
    for(i=0;i<=2*(WIDTH-1);i=i+1)//should be less than equal to because it starts from 0
    begin:loop_for_place
        //$display(i);
        //check if that bit is 1 or not
        if(((1<<i) & cin)!=0)
        begin:condition_place
            //if so set it to place
            place_out=i+1;//should be +1 because count starts from 0.
        end
    end
end
endmodule


//Name: affine_transform
//Inputs: in
//Outputs: out
//Description: This module is used to do the affine transform on the input 
//affine transform is done by xor with 01100011 and circular shift left by 1 bit of 11111000
module affine_transform(in,out);
input [7:0]in;
output [7:0]out;
//whole xor with 01100011 each bit
// //circuilar shift 11111000 ans assign
assign out[7]= ((in[7]&1) ^ (in[6]&1) ^ (in[5]&1) ^ (in[4]&1) ^ (in[3]&1) ^ (in[2]&0) ^ (in[1]&0) ^ (in[0]&0)^0);
assign out[6]= ((in[7]&0) ^ (in[6]&1) ^ (in[5]&1) ^ (in[4]&1) ^ (in[3]&1) ^ (in[2]&1) ^ (in[1]&0) ^ (in[0]&0)^1);
assign out[5]= ((in[7]&0) ^ (in[6]&0) ^ (in[5]&1) ^ (in[4]&1) ^ (in[3]&1) ^ (in[2]&1) ^ (in[1]&1) ^ (in[0]&0)^1);
assign out[4]= ((in[7]&0) ^ (in[6]&0) ^ (in[5]&0) ^ (in[4]&1) ^ (in[3]&1) ^ (in[2]&1) ^ (in[1]&1) ^ (in[0]&1)^0);
assign out[3]= ((in[7]&1) ^ (in[6]&0) ^ (in[5]&0) ^ (in[4]&0) ^ (in[3]&1) ^ (in[2]&1) ^ (in[1]&1) ^ (in[0]&1)^0);
assign out[2]= ((in[7]&1) ^ (in[6]&1) ^ (in[5]&0) ^ (in[4]&0) ^ (in[3]&0) ^ (in[2]&1) ^ (in[1]&1) ^ (in[0]&1)^0);
assign out[1]= ((in[7]&1) ^ (in[6]&1) ^ (in[5]&1) ^ (in[4]&0) ^ (in[3]&0) ^ (in[2]&0) ^ (in[1]&1) ^ (in[0]&1)^1);
assign out[0]= ((in[7]&1) ^ (in[6]&1) ^ (in[5]&1) ^ (in[4]&1) ^ (in[3]&0) ^ (in[2]&0) ^ (in[1]&0) ^ (in[0]&1)^1);
endmodule


//Name: affine_inverse_transform
//Inputs: in
//Outputs: out
//Description: This module is used to do the affine inverse transform on the input
//affine inverse transform is done by xor with 00000101 and circular shift right by 1 bit of 01010010
module affine_inverse_transform(in,out);
input [7:0]in;
output [7:0]out;
//whole xor with 00000101 each bit
// //circuilar shift  01010010
assign out[7]= ((in[7]&0) ^ (in[6]&1) ^ (in[5]&0) ^ (in[4]&1) ^ (in[3]&0) ^ (in[2]&0) ^ (in[1]&1) ^ (in[0]&0)^0);
assign out[6]= ((in[7]&0) ^ (in[6]&0) ^ (in[5]&1) ^ (in[4]&0) ^ (in[3]&1) ^ (in[2]&0) ^ (in[1]&0) ^ (in[0]&1)^0);
assign out[5]= ((in[7]&1) ^ (in[6]&0) ^ (in[5]&0) ^ (in[4]&1) ^ (in[3]&0) ^ (in[2]&1) ^ (in[1]&0) ^ (in[0]&0)^0);
assign out[4]= ((in[7]&0) ^ (in[6]&1) ^ (in[5]&0) ^ (in[4]&0) ^ (in[3]&1) ^ (in[2]&0) ^ (in[1]&1) ^ (in[0]&0)^0);
assign out[3]= ((in[7]&0) ^ (in[6]&0) ^ (in[5]&1) ^ (in[4]&0) ^ (in[3]&0) ^ (in[2]&1) ^ (in[1]&0) ^ (in[0]&1)^0);
assign out[2]= ((in[7]&1) ^ (in[6]&0) ^ (in[5]&0) ^ (in[4]&1) ^ (in[3]&0) ^ (in[2]&0) ^ (in[1]&1) ^ (in[0]&0)^1);
assign out[1]= ((in[7]&0) ^ (in[6]&1) ^ (in[5]&0) ^ (in[4]&0) ^ (in[3]&1) ^ (in[2]&0) ^ (in[1]&0) ^ (in[0]&1)^0);
assign out[0]= ((in[7]&1) ^ (in[6]&0) ^ (in[5]&1) ^ (in[4]&0) ^ (in[3]&0) ^ (in[2]&1) ^ (in[1]&0) ^ (in[0]&0)^1);
endmodule

//Name: galois_multiplication_modulous_ins
//Inputs: in
//Outputs: out
//Description: This module is used to do the galois multiplication modulous ins on the input
//we are using the galois division module to do the galois multiplication modulous ins 
//and we are using the find place module to find the place of the input
module galois_multiplication_modulous_ins #(parameter WIDTH=8)(in,out);
input [2*(WIDTH-1):0]in;
output reg [WIDTH-1:0]out;
wire [2*(WIDTH-1):0]ins[7:0];
wire [3:0]place_out[7:0];
find_place place1(in,place_out[0]);
galois_division galois1(in,place_out[0],ins[0]);
find_place place2(ins[0],place_out[1]);
galois_division galois2(ins[0],place_out[1],ins[1]);
find_place place3(ins[1],place_out[2]);
galois_division galois3(ins[1],place_out[2],ins[2]);
find_place place4(ins[2],place_out[3]);
galois_division galois4(ins[2],place_out[3],ins[3]);
find_place place5(ins[3],place_out[4]);
galois_division galois5(ins[3],place_out[4],ins[4]);
find_place place6(ins[4],place_out[5]);
galois_division galois6(ins[4],place_out[5],ins[5]);
find_place place7(ins[5],place_out[6]);
galois_division galois7(ins[5],place_out[6],ins[6]);
always @(ins[6])
begin
    #1;
    out=ins[6];
end
// always @*
// begin
//     $display("galois_multiplication_modulous_ins in=%b out=%b ins[0]=%b ins[1]=%b ins[2]=%b ins[3]=%b ins[4]=%b ins[5]=%b ins[6]=%b ins[7]=%b",in,out,ins[0],ins[1],ins[2],ins[3],ins[4],ins[5],ins[6],ins[7]);
// end
endmodule


//Name: galois_division_mod
//Inputs: in1,in2
//Outputs: out
//Description: This module is used to do the galois division mod on the input using the galois multiplication module
// and the galois multiplication modulous ins module
module galois_division_mod #(parameter WIDTH=8)(in1,in2,out);
input [WIDTH-1:0]in1;
input [WIDTH-1:0]in2;
output  [WIDTH-1:0]out;
wire [2*(WIDTH-1):0]tmp1,tmp2;
galois_multiplication galois1(in1,in2,tmp1);
galois_multiplication_modulous_ins galois2(tmp1,tmp2);
assign out=tmp2;
endmodule


module findWay(in1,in2,out1,out2);
input [7:0]in1;
input [7:0]in2;
output reg [7:0]out1;
output reg [7:0]out2;
//if in1 is 1 then send in2 to out2
//else send in2 to out1
always @(in1)
begin
    //$display("findway in1=%b in2=%b",in1,in2);
    if(in1==1)
    begin
        out2=in2;
    end
    else
    begin
        out1=in2;
    end
    //$display("findway out1=%b out2=%b",out1,out2);
end
endmodule

module increment(in,sig,out,sig_back);
input [7:0]in;
input sig;
output reg  [7:0]out;
output reg sig_back;
//if in is dont care then send 1 to out
//else send in+1 to out
always @(sig)
begin
    //$display("increment in=%b sig=%b",in,sig);
   if (sig==1)
    begin
        out=8'b0000001;
        sig_back=1;
    end
end
always @(in)
begin
    //if in=11111111 then dont increment
    if(in==8'b11111111)
    begin
        out=in;
    end
    else
    begin
        out=in+1;
    end
end
    //$display("increment out=%b sig_back=%b",out,sig_back);
//assign out=(sig==1)?1:in+1;
endmodule

//Name: galois_multiplication_inverse
//Inputs: in
//Outputs: out
//Description: This module is used to do the galois multiplication inverse on the input
//we are using the galois division module to do the galois multiplication inverse 
//and we are using the increment module to increment the input
//and we are using the findWay module to find the way of the input
module galois_multiplication_inverse #(parameter WIDTH=8)(in,out);
//find inverse of in and send it to out
input [WIDTH-1:0]in;
output  [WIDTH-1:0]out;
wire [WIDTH-1:0]in2;
wire [WIDTH-1:0]out1;
wire [WIDTH-1:0]out2;
reg sig;
wire sig_back;
//increment out1,in2
increment increment1(out2,sig,in2,sig_back);
galois_division_mod galois1(in,in2,out1);
//findWay in1,in2,out1,out2,sig;
findWay find1(out1,in2,out2,out);
// always @*
// begin
//     $display("galois_multiplication_inverse in=%b in2=%b out1=%b out2=%b sig=%b",in,in2,out1,out2,sig);
// end
always @(in)
begin
    // we have to drive the increment1 module
    sig=1;
end
always @(sig_back)
begin
    sig=0;
end
endmodule


//Name: galois_inverse_2
//Inputs: inp
//Outputs: out
//Description: This module is used to do the galois inverse on the input
//we are using the galois_multiplication module to do the galois multiplication
//and we are using the galois_division_2 module to do the galois division
module galois_inverse_2 #(parameter WIDTH=8) (inp,out);
input [7:0]inp;
output reg [7:0]out;
wire [2*(WIDTH-1):0]tmp1[255:0];
wire tmp2[255:0];
//instantiate galois_multiplication with generate block
genvar i;
generate
for(i=0;i<=255;i=i+1)
begin:starts_here
        galois_multiplication galois1(i,inp,tmp1[i]);
        galois_division_2 galois2(tmp1[i],tmp2[i]);
end
endgenerate
//check which tmp2 is 1 and send that index to out
reg [7:0]j;
always @*
begin
    for(j=0;j<255;j=j+1)
    begin
        //#10;
        //$display("galois_inverse_2 inp=%x tmp2[%x]=%x",inp,j,tmp2[j]);
        if(tmp2[j]==1)
        begin
            out=j;
        end
    end
end
endmodule


module galois_inverse_working_tb;
reg [7:0]in;
wire [7:0]out;
galois_inverse_2 galois1(in,out);
initial
begin
    $monitor("in=%x out=%x",in,out);
    in=8'b00011100;
    #100;
end
endmodule


//implementation of sbox using galois_inverse_2 and affine_transform and affine_inverse_transform
//Name: sbox_implementation
//Inputs: inp,side
//Outputs: out
//Description: This module is used to implement the sbox
//we are using the galois_inverse_2 module to do the galois inverse
//and we are using the affine_transform module to do the affine transform
//and we are using the affine_inverse_transform module to do the affine inverse transform
module sbox_implementation #(parameter WIDTH=8) (inp,side,out);
input [7:0]inp;
input side;
output [7:0]out;
wire [7:0]tmp1,tmp2,tmp3,tmp4,tmp5;
assign tmp1=inp;
assign tmp2=(side)?tmp3:tmp1;
affine_transform affine1(tmp1,tmp3);
galois_inverse_2 inverse(tmp2,tmp4);
assign out=(side)?tmp4:tmp5;
affine_inverse_transform affine2(tmp4,tmp5);
endmodule