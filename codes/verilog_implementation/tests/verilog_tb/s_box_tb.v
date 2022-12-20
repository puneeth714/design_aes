`include "verilog_implementation/src/subBytes/s_box.v"
module test_s_box_multiplication;
reg [7:0] a,b;
wire [14:0] c;

//widhth is 8
galois_multiplication #(8) s_box1(a,b,c);

initial begin
    a=255;
    b=255;
    #10;
    $display("a=%b",a);
    $display("b=%b",b);
    $display("c=%b",c);
end
endmodule

module test_s_box_modulos;
reg  [14:0] cin;
wire   [7:0] cout;
galois_multiplication_modulous g1(cin,cout);
initial begin
    $monitor("input is %b output is %b",cin,cout);
    // repeat (20)
    //     #10 cin=$random % 15;
    cin=15'b000101111110100;
    #20;
end
endmodule

module find_place_tb;
reg [14:0]cin;
wire [3:0]place_out;
find_place c(cin,place_out);
initial
begin
    $monitor("cin=%b place_out=%b",cin,place_out);
cin=15'b111111111111111;
#10;
cin=15'b000111111111110;
#10;
end
endmodule

module galois_division_tb;
reg [14:0]cin;
wire [3:0] place_out;
reg [3:0]place;
wire [14:0]cout;
find_place place_find(cin,place_out);
galois_division #8 galois_division_inst(cin,place_out,cout);
initial begin
    $monitor("%b %b %b",cin,place,cout);
    cin=15'b111111111111111;
    place=4'b1111;
    #10;
    cin=15'b000101111110100;
    place=4'b1100;
    #10;
    // repeat(100)begin
    //     cin=$random;
    //     place=$random;
    //     #10;
    
end
endmodule

module galois_multiplication_modulous_ins_tb;
reg [14:0]in;
wire [7:0]out;
galois_multiplication_modulous_ins galois1(in,out);
initial
begin
    $monitor("%b %b",in,out);
    in=15'b001110000100000;
    #10;
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



module galois_division_mod_tb1;
reg [7:0]in1;
reg [7:0]in2;
wire [7:0]out;
galois_division_mod galois_mod(in1,in2,out);
initial
begin
    $monitor("in1=%b in2=%b out=%b",in1,in2,out);
    // in1=8'b00000101;
    // in2=8'b00000011;
    // #10;
    repeat(100)
    begin
        in1=8'b01111000;
        in2=8'b10110110;
        #10;
    end
end
endmodule