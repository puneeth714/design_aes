input  [2*(WIDTH-1):0] cin;
output   [WIDTH-1:0] cout;
// reg divisior=9'b100011011;
wire [3:0]place;
reg [2*(WIDTH-1):0] keep_on;
wire [14:0]out;
findplace f1(keep_on,place);
divide d1(keep_on,place,out);
// wire k;
// assign k=findPlace(cin);

// assign cout=divide(cin,k);


// always @(cin)
// begin
//     //place=findPlace(cin);
//     keep_on=divide(cin,place);
// end

assign cout=out;
endmodule

module findplace(keep_on,out);
input [14:0] keep_on;
output reg [3:0]out;
reg [3:0]i;
initial
begin
for( i=14;i > 0;i=i-1)
 begin
    if(((1<<i) & keep_on) == 1)
    begin:found
        out=i;
    end
end
end
endmodule

module divide(keep_on1,place,out);
input [14:0] keep_on1;
input [3:0]place;
output reg [14:0] out;
reg [3:0]i;
reg [14:0] keep_on;

initial
begin
// while(place >=8)
for(i=0;i<14;i=i+1)
begin:loop_division
    keep_on = (((keep_on >> place- 9 ) ^ 283)<<place-9) | ((keep_on<<9) >> 9);
    // (((value >> (place - 9)) ^ 283) << (place - 9)) | ((value << 9) >> 9);
    //place =findPlace(keep_on);
    //findplace f(keep_on,place);
    if(place<8)
    begin
        out=keep_on;
    end
    //$display(i);
end
end
endmodule