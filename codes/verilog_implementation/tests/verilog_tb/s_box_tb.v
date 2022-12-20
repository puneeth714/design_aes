//`include "verilog_implementation/src/subBytes/s_box.v"
module test_s_box;
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