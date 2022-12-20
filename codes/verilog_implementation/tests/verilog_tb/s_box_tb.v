//`include "verilog_implementation/src/subBytes/s_box.v"
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