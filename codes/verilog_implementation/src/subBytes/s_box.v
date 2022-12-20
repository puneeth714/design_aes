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

module affine_inverse_transform(in,out);
input [7:0]in;
output [7:0]out;
//whole xor with 00000101 each bit
// //circuilar shift  01010010
assign out[7]= ((in[7]&0) ^ (in[6]&1) ^ (in[5]&0) ^ (in[4]&1) ^ (in[3]&0) ^ (in[2]&0) ^ (in[1]&1) ^ (in[0]&0)^0);
assign out[6]= ((in[7]&1) ^ (in[6]&0) ^ (in[5]&1) ^ (in[4]&0) ^ (in[3]&1) ^ (in[2]&0) ^ (in[1]&0) ^ (in[0]&1)^0);
assign out[5]= ((in[7]&0) ^ (in[6]&1) ^ (in[5]&0) ^ (in[4]&1) ^ (in[3]&0) ^ (in[2]&1) ^ (in[1]&0) ^ (in[0]&0)^0);
assign out[4]= ((in[7]&1) ^ (in[6]&0) ^ (in[5]&1) ^ (in[4]&0) ^ (in[3]&1) ^ (in[2]&0) ^ (in[1]&1) ^ (in[0]&0)^0);
assign out[3]= ((in[7]&0) ^ (in[6]&1) ^ (in[5]&0) ^ (in[4]&1) ^ (in[3]&0) ^ (in[2]&1) ^ (in[1]&0) ^ (in[0]&1)^0);
assign out[2]= ((in[7]&1) ^ (in[6]&0) ^ (in[5]&1) ^ (in[4]&0) ^ (in[3]&1) ^ (in[2]&0) ^ (in[1]&1) ^ (in[0]&1)^1);
assign out[1]= ((in[7]&0) ^ (in[6]&1) ^ (in[5]&0) ^ (in[4]&1) ^ (in[3]&0) ^ (in[2]&1) ^ (in[1]&0) ^ (in[0]&1)^0);
assign out[0]= ((in[7]&1) ^ (in[6]&0) ^ (in[5]&1) ^ (in[4]&0) ^ (in[3]&1) ^ (in[2]&0) ^ (in[1]&1) ^ (in[0]&1)^1);
endmodule

module galois_multiplication_inverse(in,out);
input [7:0]in;
output [7:0]out;
endmodule

module galois_multiplication_modulous_ins #(parameter WIDTH=8)(in,out);
input [2*(WIDTH-1):0]in;
output [WIDTH-1:0]out;
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
galois_division galois7(ins[5],place_out[6],out);
endmodule


module galois_division_mod #(parameter WIDTH=8)(in1,in2,out);
input [WIDTH-1:0]in1;
input [WIDTH-1:0]in2;
output  [WIDTH-1:0]out;
wire [2*(WIDTH-1):0]tmp1,tmp2;
galois_multiplication galois1(in1,in2,tmp1);
galois_multiplication_modulous_ins galois2(tmp1,tmp2);
assign out=tmp2;
endmodule


module galois_inverse #(parameter WIDTH=8)(in,out);
input [WIDTH-1:0]in;
output  [WIDTH-1:0]out;
reg [WIDTH-1:0]tmp1;
wire [WIDTH-1:0]tmp2;
//call galois_division_mod with in1=in and in2=0 to 255 and check for 1 in out
//if 1 is found then that is the inverse of in send it to out
galois_division_mod galois1(in,tmp1,tmp2);
assign out=(tmp2 ==1)?tmp1:0;
always @(in)
begin:for_loop
    reg [WIDTH-1:0]i;
    $display("i %b",i);
    for(i=1;i<2**(WIDTH-1);i=i+1)
        begin
            //$display("i %b",i);
            tmp1=i;
            $display("tmp2 %b",tmp2);
            if(tmp2==1)
            begin
                out=i;
            end
        end
    end
endmodule

module galois_inverse_tb;
reg [7:0]in;
wire [7:0]out;
galois_inverse galois1(in,out);
initial
begin
    $monitor(" %b %b",in,out);
    in=8'b11111111;
    #10;
end
endmodule

