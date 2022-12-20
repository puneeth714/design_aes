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
output   [WIDTH-1:0] cout;
// reg divisior=9'b100011011;
reg [4:0]place;
reg [2*(WIDTH-1):0] keep_on;
// wire k;
// assign k=findPlace(cin);

// assign cout=divide(cin,k);
function   findPlace;
input [2*(WIDTH-1):0] keep_on;
reg [4:0]i;
begin
for( i=(2*(WIDTH-1));i > 0;i=i-1)
 begin
    if(((1<<i) & keep_on) == 1)
    begin:found
        findPlace=i;
    end
end
end
endfunction

function  divide;
input [2*(WIDTH-1):0] keep_on,place;
reg [4:0]i;

begin
// while(place >=8)
for(i=0;i<2*(WIDTH-1);i=i+1)
begin:loop_division
    keep_on = (((keep_on >> place- 9 ) ^ 283)<<place-9) | ((keep_on<<9) >> 9);
    // (((value >> (place - 9)) ^ 283) << (place - 9)) | ((value << 9) >> 9);
    place =findPlace(keep_on);
    if(place<8)
    begin
        divide=keep_on;
    end
    //$display(i);
end
end
endfunction

always @(cin)
begin
    place=findPlace(cin);
    keep_on=divide(2,place);
end
assign cout=keep_on;
endmodule

