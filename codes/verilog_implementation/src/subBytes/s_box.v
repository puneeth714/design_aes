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

module galois_inverse_tb;
reg [7:0]in;
wire [7:0]out;
galois_multiplication_inverse galois1(in,out);
initial
begin
    //monitor all the signals internally also
    $monitor("in=%x out=%x",in,out);
    in=8'b10110110;
end
endmodule


// module galois_division_mod_tb;
// reg [7:0]in1;
// reg [7:0]in2;
// wire [7:0]out;
// galois_division_mod galois_mod(in1,in2,out);
// initial
// begin
//     $monitor("in1=%b in2=%b out=%b",in1,in2,out);
//     in1=8'b10110110;
//     in2=8'b00000110;
//     #10; 
// end
// endmodule