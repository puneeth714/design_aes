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
reg done=0;
always @(cin)
begin:find_place
    reg [3:0]i;
    reg set;
    set=0;
    //when cin changes find the place and store in place
    for(i=(2*(WIDTH-1));i>0;i=i-1)
    begin:loop_for_place
        //check if that bit is 1 or not
        //$display((1<<i) & cin);
        if(((1<<i) & cin)!=0 && set ==0 && done == 0)
        begin:condition_place
            //if so set it to place
            if(i<8)
            begin:if_done
                done=1;
            end
            place=i;
            keep_on=cin;
            set=1;
            //set i to 0 so it will not run again
        end
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
        keep_on = (keep_on ^ (283 <<(place-8)));
    //$display("done %d",keep_on);
    end
    
end

always @(*)
begin
        cout=keep_on;
end
endmodule

module test;
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