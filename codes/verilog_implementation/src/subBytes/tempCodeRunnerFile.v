module galois_inverse_tb;
reg [7:0]in;
wire [7:0]out;
galois_multiplication_inverse galois1(in,out);
initial
begin
    //monitor all the signals internally also
    $monitor("in=%x out=%x",in,out);
    in=8'b10110110;
    #1;
end
endmodule
