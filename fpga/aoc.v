module bcd (
    start_value,
    reset,
    clock,
    increment,
    convert,
    ready,
    bcd_value,
    int_value,
    num_digits,
    is_invalid
);

    input [33:0] start_value;
    input reset;
    input clock;
    input increment;
    input convert;
    output ready;
    output [43:0] bcd_value;
    output [33:0] int_value;
    output [4:0] num_digits;
    output is_invalid;

    wire _56;
    wire [19:0] _52;
    wire [19:0] _51;
    wire _53;
    wire [15:0] _49;
    wire [15:0] _48;
    wire _50;
    wire [11:0] _46;
    wire [11:0] _45;
    wire _47;
    wire [7:0] _43;
    wire [7:0] _42;
    wire _44;
    wire [3:0] _40;
    wire [3:0] _39;
    wire _41;
    wire [3:0] _34;
    wire [4:0] _35;
    reg _54;
    wire _32;
    wire _55;
    wire _58;
    reg _60;
    wire _1;
    reg _57;
    wire [4:0] _30;
    wire [4:0] _104;
    wire [3:0] _102;
    wire [3:0] _101;
    wire _103;
    wire [4:0] _106;
    wire [4:0] _100;
    wire [3:0] _97;
    wire _99;
    wire [4:0] _107;
    wire [4:0] _96;
    wire [3:0] _93;
    wire _95;
    wire [4:0] _108;
    wire [4:0] _92;
    wire [3:0] _89;
    wire _91;
    wire [4:0] _109;
    wire [4:0] _88;
    wire [3:0] _85;
    wire _87;
    wire [4:0] _110;
    wire [4:0] _84;
    wire [3:0] _81;
    wire _83;
    wire [4:0] _111;
    wire [4:0] _80;
    wire [3:0] _77;
    wire _79;
    wire [4:0] _112;
    wire [4:0] _76;
    wire [3:0] _73;
    wire _75;
    wire [4:0] _113;
    wire [4:0] _72;
    wire [3:0] _69;
    wire _71;
    wire [4:0] _114;
    wire [4:0] _68;
    wire [3:0] _65;
    wire _67;
    wire [4:0] _115;
    wire [4:0] _64;
    wire [3:0] _61;
    wire _63;
    wire [4:0] _116;
    wire [4:0] _117;
    reg [4:0] _118;
    wire [4:0] _3;
    reg [4:0] _31;
    wire [33:0] _119;
    wire [33:0] _123;
    wire [33:0] _124;
    wire [33:0] _121;
    reg [33:0] _126;
    wire [33:0] _5;
    reg [33:0] _120;
    wire [43:0] _37;
    wire [3:0] _341;
    wire [3:0] _342;
    wire [3:0] _338;
    wire _339;
    wire _340;
    wire [3:0] _344;
    wire [3:0] _334;
    wire _331;
    wire _332;
    wire [3:0] _336;
    wire [3:0] _337;
    wire [3:0] _326;
    wire _323;
    wire _324;
    wire [3:0] _328;
    wire [3:0] _329;
    wire [3:0] _318;
    wire _315;
    wire _316;
    wire [3:0] _320;
    wire [3:0] _321;
    wire [3:0] _310;
    wire _307;
    wire _308;
    wire [3:0] _312;
    wire [3:0] _313;
    wire [3:0] _302;
    wire _299;
    wire _300;
    wire [3:0] _304;
    wire [3:0] _305;
    wire [3:0] _294;
    wire _291;
    wire _292;
    wire [3:0] _296;
    wire [3:0] _297;
    wire [3:0] _286;
    wire _283;
    wire _284;
    wire [3:0] _288;
    wire [3:0] _289;
    wire [3:0] _278;
    wire _275;
    wire _276;
    wire [3:0] _280;
    wire [3:0] _281;
    wire [3:0] _270;
    wire _267;
    wire _268;
    wire [3:0] _272;
    wire [3:0] _273;
    wire [3:0] _262;
    wire _259;
    wire _260;
    wire [3:0] _264;
    wire [3:0] _257;
    wire [3:0] _253;
    wire _255;
    wire [3:0] _249;
    wire _251;
    wire [3:0] _245;
    wire _247;
    wire [3:0] _241;
    wire _243;
    wire [3:0] _237;
    wire _239;
    wire [3:0] _233;
    wire _235;
    wire [3:0] _229;
    wire _231;
    wire [3:0] _225;
    wire _227;
    wire [3:0] _221;
    wire _223;
    wire [3:0] _218;
    wire _220;
    wire _224;
    wire _228;
    wire _232;
    wire _236;
    wire _240;
    wire _244;
    wire _248;
    wire _252;
    wire _256;
    wire [3:0] _265;
    wire [43:0] _345;
    wire [32:0] _130;
    wire [33:0] _132;
    wire [33:0] _8;
    wire [33:0] _129;
    reg [33:0] _134;
    wire [33:0] _9;
    reg [33:0] convert_buffer;
    wire _216;
    wire [3:0] _211;
    wire [3:0] _212;
    wire [3:0] _208;
    wire [3:0] _207;
    wire _209;
    wire _210;
    wire [3:0] _213;
    wire [3:0] _205;
    wire [3:0] _200;
    wire _202;
    wire _203;
    wire [3:0] _206;
    wire [3:0] _198;
    wire [3:0] _193;
    wire _195;
    wire _196;
    wire [3:0] _199;
    wire [3:0] _191;
    wire [3:0] _186;
    wire _188;
    wire _189;
    wire [3:0] _192;
    wire [3:0] _184;
    wire [3:0] _179;
    wire _181;
    wire _182;
    wire [3:0] _185;
    wire [3:0] _177;
    wire [3:0] _172;
    wire _174;
    wire _175;
    wire [3:0] _178;
    wire [3:0] _170;
    wire [3:0] _165;
    wire _167;
    wire _168;
    wire [3:0] _171;
    wire [3:0] _163;
    wire [3:0] _158;
    wire _160;
    wire _161;
    wire [3:0] _164;
    wire [3:0] _156;
    wire [3:0] _151;
    wire _153;
    wire _154;
    wire [3:0] _157;
    wire [3:0] _149;
    wire [3:0] _144;
    wire _146;
    wire _147;
    wire [3:0] _150;
    wire [3:0] _142;
    wire [3:0] _137;
    wire _139;
    wire _140;
    wire [3:0] _143;
    wire [43:0] _214;
    wire [42:0] _215;
    wire [43:0] _217;
    wire [43:0] _136;
    reg [43:0] _346;
    wire [43:0] _10;
    reg [43:0] _38;
    wire _364;
    wire [1:0] _25;
    wire vdd;
    wire gnd;
    wire _348;
    reg _349;
    wire _12;
    reg _28;
    wire _29;
    wire [1:0] _362;
    wire [1:0] _59;
    wire [5:0] _359;
    wire [5:0] _350;
    wire _14;
    wire _16;
    wire [5:0] _354;
    wire [5:0] _355;
    wire [5:0] _353;
    reg [5:0] _356;
    wire [5:0] _17;
    reg [5:0] bits_processed;
    wire _360;
    wire [1:0] _361;
    wire [1:0] _133;
    wire [1:0] _125;
    wire _19;
    wire [1:0] _357;
    wire _21;
    wire [1:0] _358;
    reg [1:0] _363;
    wire [1:0] _22;
    (* fsm_encoding="one_hot" *)
    reg [1:0] _26;
    reg _365;
    wire _23;
    assign _56 = 1'b0;
    assign _52 = _38[39:20];
    assign _51 = _38[19:0];
    assign _53 = _51 == _52;
    assign _49 = _38[31:16];
    assign _48 = _38[15:0];
    assign _50 = _48 == _49;
    assign _46 = _38[23:12];
    assign _45 = _38[11:0];
    assign _47 = _45 == _46;
    assign _43 = _38[15:8];
    assign _42 = _38[7:0];
    assign _44 = _42 == _43;
    assign _40 = _38[7:4];
    assign _39 = _38[3:0];
    assign _41 = _39 == _40;
    assign _34 = _31[4:1];
    assign _35 = { _56,
                   _34 };
    always @* begin
        case (_35)
        0:
            _54 <= gnd;
        1:
            _54 <= _41;
        2:
            _54 <= _44;
        3:
            _54 <= _47;
        4:
            _54 <= _50;
        default:
            _54 <= _53;
        endcase
    end
    assign _32 = _31[0:0];
    assign _55 = _32 ? gnd : _54;
    assign _58 = _29 ? _57 : _55;
    always @* begin
        case (_26)
        2'b11:
            _60 <= _58;
        default:
            _60 <= _57;
        endcase
    end
    assign _1 = _60;
    always @(posedge _16) begin
        if (_14)
            _57 <= _56;
        else
            _57 <= _1;
    end
    assign _30 = 5'b00000;
    assign _104 = 5'b00001;
    assign _102 = 4'b0000;
    assign _101 = _38[3:0];
    assign _103 = _101 == _102;
    assign _106 = _103 ? _30 : _104;
    assign _100 = 5'b00010;
    assign _97 = _38[7:4];
    assign _99 = _97 == _102;
    assign _107 = _99 ? _106 : _100;
    assign _96 = 5'b00011;
    assign _93 = _38[11:8];
    assign _95 = _93 == _102;
    assign _108 = _95 ? _107 : _96;
    assign _92 = 5'b00100;
    assign _89 = _38[15:12];
    assign _91 = _89 == _102;
    assign _109 = _91 ? _108 : _92;
    assign _88 = 5'b00101;
    assign _85 = _38[19:16];
    assign _87 = _85 == _102;
    assign _110 = _87 ? _109 : _88;
    assign _84 = 5'b00110;
    assign _81 = _38[23:20];
    assign _83 = _81 == _102;
    assign _111 = _83 ? _110 : _84;
    assign _80 = 5'b00111;
    assign _77 = _38[27:24];
    assign _79 = _77 == _102;
    assign _112 = _79 ? _111 : _80;
    assign _76 = 5'b01000;
    assign _73 = _38[31:28];
    assign _75 = _73 == _102;
    assign _113 = _75 ? _112 : _76;
    assign _72 = 5'b01001;
    assign _69 = _38[35:32];
    assign _71 = _69 == _102;
    assign _114 = _71 ? _113 : _72;
    assign _68 = 5'b01010;
    assign _65 = _38[39:36];
    assign _67 = _65 == _102;
    assign _115 = _67 ? _114 : _68;
    assign _64 = 5'b01011;
    assign _61 = _38[43:40];
    assign _63 = _61 == _102;
    assign _116 = _63 ? _115 : _64;
    assign _117 = _29 ? _116 : _31;
    always @* begin
        case (_26)
        2'b11:
            _118 <= _117;
        default:
            _118 <= _31;
        endcase
    end
    assign _3 = _118;
    always @(posedge _16) begin
        if (_14)
            _31 <= _30;
        else
            _31 <= _3;
    end
    assign _119 = 34'b0000000000000000000000000000000000;
    assign _123 = 34'b0000000000000000000000000000000001;
    assign _124 = _120 + _123;
    assign _121 = _21 ? _8 : _120;
    always @* begin
        case (_26)
        2'b00:
            _126 <= _121;
        2'b10:
            _126 <= _124;
        default:
            _126 <= _120;
        endcase
    end
    assign _5 = _126;
    always @(posedge _16) begin
        if (_14)
            _120 <= _119;
        else
            _120 <= _5;
    end
    assign _37 = 44'b00000000000000000000000000000000000000000000;
    assign _341 = 4'b0001;
    assign _342 = _218 + _341;
    assign _338 = 4'b1001;
    assign _339 = _218 < _338;
    assign _340 = ~ _339;
    assign _344 = _340 ? _102 : _342;
    assign _334 = _221 + _341;
    assign _331 = _221 < _338;
    assign _332 = ~ _331;
    assign _336 = _332 ? _102 : _334;
    assign _337 = _220 ? _336 : _221;
    assign _326 = _225 + _341;
    assign _323 = _225 < _338;
    assign _324 = ~ _323;
    assign _328 = _324 ? _102 : _326;
    assign _329 = _224 ? _328 : _225;
    assign _318 = _229 + _341;
    assign _315 = _229 < _338;
    assign _316 = ~ _315;
    assign _320 = _316 ? _102 : _318;
    assign _321 = _228 ? _320 : _229;
    assign _310 = _233 + _341;
    assign _307 = _233 < _338;
    assign _308 = ~ _307;
    assign _312 = _308 ? _102 : _310;
    assign _313 = _232 ? _312 : _233;
    assign _302 = _237 + _341;
    assign _299 = _237 < _338;
    assign _300 = ~ _299;
    assign _304 = _300 ? _102 : _302;
    assign _305 = _236 ? _304 : _237;
    assign _294 = _241 + _341;
    assign _291 = _241 < _338;
    assign _292 = ~ _291;
    assign _296 = _292 ? _102 : _294;
    assign _297 = _240 ? _296 : _241;
    assign _286 = _245 + _341;
    assign _283 = _245 < _338;
    assign _284 = ~ _283;
    assign _288 = _284 ? _102 : _286;
    assign _289 = _244 ? _288 : _245;
    assign _278 = _249 + _341;
    assign _275 = _249 < _338;
    assign _276 = ~ _275;
    assign _280 = _276 ? _102 : _278;
    assign _281 = _248 ? _280 : _249;
    assign _270 = _253 + _341;
    assign _267 = _253 < _338;
    assign _268 = ~ _267;
    assign _272 = _268 ? _102 : _270;
    assign _273 = _252 ? _272 : _253;
    assign _262 = _257 + _341;
    assign _259 = _257 < _338;
    assign _260 = ~ _259;
    assign _264 = _260 ? _102 : _262;
    assign _257 = _38[43:40];
    assign _253 = _38[39:36];
    assign _255 = _253 == _338;
    assign _249 = _38[35:32];
    assign _251 = _249 == _338;
    assign _245 = _38[31:28];
    assign _247 = _245 == _338;
    assign _241 = _38[27:24];
    assign _243 = _241 == _338;
    assign _237 = _38[23:20];
    assign _239 = _237 == _338;
    assign _233 = _38[19:16];
    assign _235 = _233 == _338;
    assign _229 = _38[15:12];
    assign _231 = _229 == _338;
    assign _225 = _38[11:8];
    assign _227 = _225 == _338;
    assign _221 = _38[7:4];
    assign _223 = _221 == _338;
    assign _218 = _38[3:0];
    assign _220 = _218 == _338;
    assign _224 = _220 ? _223 : gnd;
    assign _228 = _224 ? _227 : gnd;
    assign _232 = _228 ? _231 : gnd;
    assign _236 = _232 ? _235 : gnd;
    assign _240 = _236 ? _239 : gnd;
    assign _244 = _240 ? _243 : gnd;
    assign _248 = _244 ? _247 : gnd;
    assign _252 = _248 ? _251 : gnd;
    assign _256 = _252 ? _255 : gnd;
    assign _265 = _256 ? _264 : _257;
    assign _345 = { _265,
                    _273,
                    _281,
                    _289,
                    _297,
                    _305,
                    _313,
                    _321,
                    _329,
                    _337,
                    _344 };
    assign _130 = convert_buffer[32:0];
    assign _132 = { _130,
                    _56 };
    assign _8 = start_value;
    assign _129 = _21 ? _8 : convert_buffer;
    always @* begin
        case (_26)
        2'b00:
            _134 <= _129;
        2'b01:
            _134 <= _132;
        default:
            _134 <= convert_buffer;
        endcase
    end
    assign _9 = _134;
    always @(posedge _16) begin
        if (_14)
            convert_buffer <= _119;
        else
            convert_buffer <= _9;
    end
    assign _216 = convert_buffer[33:33];
    assign _211 = 4'b0011;
    assign _212 = _207 + _211;
    assign _208 = 4'b0101;
    assign _207 = _38[3:0];
    assign _209 = _207 < _208;
    assign _210 = ~ _209;
    assign _213 = _210 ? _212 : _207;
    assign _205 = _200 + _211;
    assign _200 = _38[7:4];
    assign _202 = _200 < _208;
    assign _203 = ~ _202;
    assign _206 = _203 ? _205 : _200;
    assign _198 = _193 + _211;
    assign _193 = _38[11:8];
    assign _195 = _193 < _208;
    assign _196 = ~ _195;
    assign _199 = _196 ? _198 : _193;
    assign _191 = _186 + _211;
    assign _186 = _38[15:12];
    assign _188 = _186 < _208;
    assign _189 = ~ _188;
    assign _192 = _189 ? _191 : _186;
    assign _184 = _179 + _211;
    assign _179 = _38[19:16];
    assign _181 = _179 < _208;
    assign _182 = ~ _181;
    assign _185 = _182 ? _184 : _179;
    assign _177 = _172 + _211;
    assign _172 = _38[23:20];
    assign _174 = _172 < _208;
    assign _175 = ~ _174;
    assign _178 = _175 ? _177 : _172;
    assign _170 = _165 + _211;
    assign _165 = _38[27:24];
    assign _167 = _165 < _208;
    assign _168 = ~ _167;
    assign _171 = _168 ? _170 : _165;
    assign _163 = _158 + _211;
    assign _158 = _38[31:28];
    assign _160 = _158 < _208;
    assign _161 = ~ _160;
    assign _164 = _161 ? _163 : _158;
    assign _156 = _151 + _211;
    assign _151 = _38[35:32];
    assign _153 = _151 < _208;
    assign _154 = ~ _153;
    assign _157 = _154 ? _156 : _151;
    assign _149 = _144 + _211;
    assign _144 = _38[39:36];
    assign _146 = _144 < _208;
    assign _147 = ~ _146;
    assign _150 = _147 ? _149 : _144;
    assign _142 = _137 + _211;
    assign _137 = _38[43:40];
    assign _139 = _137 < _208;
    assign _140 = ~ _139;
    assign _143 = _140 ? _142 : _137;
    assign _214 = { _143,
                    _150,
                    _157,
                    _164,
                    _171,
                    _178,
                    _185,
                    _192,
                    _199,
                    _206,
                    _213 };
    assign _215 = _214[42:0];
    assign _217 = { _215,
                    _216 };
    assign _136 = _21 ? _37 : _38;
    always @* begin
        case (_26)
        2'b00:
            _346 <= _136;
        2'b01:
            _346 <= _217;
        2'b10:
            _346 <= _345;
        default:
            _346 <= _38;
        endcase
    end
    assign _10 = _346;
    always @(posedge _16) begin
        if (_14)
            _38 <= _37;
        else
            _38 <= _10;
    end
    assign _364 = _21 ? gnd : vdd;
    assign _25 = 2'b00;
    assign vdd = 1'b1;
    assign gnd = 1'b0;
    assign _348 = _29 ? vdd : gnd;
    always @* begin
        case (_26)
        2'b11:
            _349 <= _348;
        default:
            _349 <= _28;
        endcase
    end
    assign _12 = _349;
    always @(posedge _16) begin
        if (_14)
            _28 <= _56;
        else
            _28 <= _12;
    end
    assign _29 = ~ _28;
    assign _362 = _29 ? _26 : _25;
    assign _59 = 2'b11;
    assign _359 = 6'b100001;
    assign _350 = 6'b000000;
    assign _14 = reset;
    assign _16 = clock;
    assign _354 = 6'b000001;
    assign _355 = bits_processed + _354;
    assign _353 = _21 ? _350 : bits_processed;
    always @* begin
        case (_26)
        2'b00:
            _356 <= _353;
        2'b01:
            _356 <= _355;
        default:
            _356 <= bits_processed;
        endcase
    end
    assign _17 = _356;
    always @(posedge _16) begin
        if (_14)
            bits_processed <= _350;
        else
            bits_processed <= _17;
    end
    assign _360 = bits_processed == _359;
    assign _361 = _360 ? _59 : _26;
    assign _133 = 2'b01;
    assign _125 = 2'b10;
    assign _19 = increment;
    assign _357 = _19 ? _125 : _26;
    assign _21 = convert;
    assign _358 = _21 ? _133 : _357;
    always @* begin
        case (_26)
        2'b00:
            _363 <= _358;
        2'b01:
            _363 <= _361;
        2'b10:
            _363 <= _59;
        2'b11:
            _363 <= _362;
        default:
            _363 <= _26;
        endcase
    end
    assign _22 = _363;
    always @(posedge _16) begin
        if (_14)
            _26 <= _25;
        else
            _26 <= _22;
    end
    always @* begin
        case (_26)
        2'b00:
            _365 <= _364;
        default:
            _365 <= gnd;
        endcase
    end
    assign _23 = _365;
    assign ready = _23;
    assign bcd_value = _38;
    assign int_value = _120;
    assign num_digits = _31;
    assign is_invalid = _57;

endmodule
module aoc (
    data$value,
    data$valid,
    reset,
    clock,
    puzzle,
    result$valid,
    result$value,
    data_ready,
    debug
);

    input [63:0] data$value;
    input data$valid;
    input reset;
    input clock;
    input [4:0] puzzle;
    output result$valid;
    output [63:0] result$value;
    output data_ready;
    output [1:0] debug;

    wire [1:0] _29;
    wire [1:0] _63;
    wire [1:0] _59;
    wire [1:0] _58;
    wire [1:0] _60;
    wire [1:0] _61;
    wire [1:0] _62;
    wire [1:0] _64;
    wire [1:0] _66;
    wire [1:0] _67;
    wire [1:0] _1;
    reg [1:0] _30;
    wire _68;
    wire _72;
    wire _70;
    wire _71;
    wire _73;
    wire _74;
    wire _3;
    reg _69;
    wire [63:0] _89;
    wire [33:0] _79;
    wire [29:0] _78;
    wire [63:0] _80;
    wire [63:0] _81;
    wire _77;
    wire [63:0] _82;
    wire [63:0] _83;
    wire [63:0] _84;
    wire [63:0] _85;
    wire [63:0] _86;
    wire [63:0] _87;
    wire [63:0] _88;
    wire [63:0] _5;
    reg [63:0] invalid_sum;
    wire [63:0] _91;
    wire [63:0] _92;
    wire [63:0] _93;
    wire [63:0] _94;
    wire [63:0] _95;
    wire [63:0] _6;
    reg [63:0] _90;
    wire _150;
    wire _151;
    wire _152;
    wire [33:0] _33;
    wire [33:0] _146;
    wire [33:0] _147;
    wire [33:0] _142;
    wire [33:0] _143;
    wire [33:0] _144;
    wire [63:0] _9;
    wire [33:0] _136;
    wire _11;
    wire [33:0] _137;
    wire [33:0] _133;
    wire [33:0] _134;
    wire _126;
    wire [33:0] _97;
    wire [33:0] _96;
    wire [33:0] _98;
    wire [33:0] _99;
    wire [33:0] _100;
    wire [33:0] _101;
    wire [33:0] _12;
    reg [33:0] range;
    wire [33:0] _118;
    wire _56;
    wire _102;
    wire _103;
    wire _104;
    wire _105;
    wire _106;
    wire _107;
    wire _13;
    reg _51;
    wire gnd;
    wire _109;
    wire _110;
    wire _111;
    wire _112;
    wire _14;
    reg _49;
    wire _16;
    wire _18;
    wire [84:0] _52;
    wire _53;
    wire _54;
    wire _57;
    wire [33:0] _119;
    wire [33:0] _116;
    wire [33:0] _120;
    wire [33:0] _121;
    wire [33:0] _122;
    wire [33:0] _123;
    wire [33:0] _124;
    wire [33:0] _19;
    reg [33:0] range_counter;
    wire _47;
    wire _127;
    wire vdd;
    wire _108;
    wire _125;
    wire _128;
    wire _129;
    wire _130;
    wire _131;
    wire _20;
    reg _40;
    wire _42;
    wire [33:0] _135;
    wire [33:0] _138;
    wire [33:0] _139;
    wire [33:0] _140;
    wire [33:0] _21;
    reg [33:0] _36;
    wire _38;
    wire [33:0] _145;
    wire [33:0] _148;
    wire [33:0] _149;
    wire [33:0] _22;
    reg [33:0] _32;
    wire _34;
    wire _153;
    wire [4:0] _27;
    wire [4:0] _24;
    wire _28;
    wire _154;
    wire _25;
    reg _114;
    assign _29 = 2'b00;
    assign _63 = 2'b01;
    assign _59 = 2'b11;
    assign _58 = 2'b10;
    assign _60 = _57 ? _59 : _58;
    assign _61 = _47 ? _60 : _30;
    assign _62 = _42 ? _61 : _30;
    assign _64 = _38 ? _63 : _62;
    assign _66 = _34 ? _29 : _64;
    assign _67 = _28 ? _66 : _30;
    assign _1 = _67;
    always @(posedge _18) begin
        if (_16)
            _30 <= _29;
        else
            _30 <= _1;
    end
    assign _68 = 1'b0;
    assign _72 = _11 ? gnd : vdd;
    assign _70 = _11 ? gnd : vdd;
    assign _71 = _38 ? _70 : gnd;
    assign _73 = _34 ? _72 : _71;
    assign _74 = _28 ? _73 : _69;
    assign _3 = _74;
    always @(posedge _18) begin
        if (_16)
            _69 <= _68;
        else
            _69 <= _3;
    end
    assign _89 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
    assign _79 = _52[78:45];
    assign _78 = 30'b000000000000000000000000000000;
    assign _80 = { _78,
                   _79 };
    assign _81 = invalid_sum + _80;
    assign _77 = _52[84:84];
    assign _82 = _77 ? _81 : invalid_sum;
    assign _83 = _57 ? _82 : invalid_sum;
    assign _84 = _47 ? _83 : invalid_sum;
    assign _85 = _42 ? _84 : invalid_sum;
    assign _86 = _38 ? invalid_sum : _85;
    assign _87 = _34 ? invalid_sum : _86;
    assign _88 = _28 ? _87 : invalid_sum;
    assign _5 = _88;
    always @(posedge _18) begin
        if (_16)
            invalid_sum <= _89;
        else
            invalid_sum <= _5;
    end
    assign _91 = _47 ? _90 : invalid_sum;
    assign _92 = _42 ? _91 : _90;
    assign _93 = _38 ? _90 : _92;
    assign _94 = _34 ? _90 : _93;
    assign _95 = _28 ? _94 : _90;
    assign _6 = _95;
    always @(posedge _18) begin
        if (_16)
            _90 <= _89;
        else
            _90 <= _6;
    end
    assign _150 = _47 ? gnd : vdd;
    assign _151 = _42 ? _150 : gnd;
    assign _152 = _38 ? _114 : _151;
    assign _33 = 34'b0000000000000000000000000000000000;
    assign _146 = _9[33:0];
    assign _147 = _11 ? _146 : _32;
    assign _142 = _114 ? _33 : _32;
    assign _143 = _47 ? _32 : _142;
    assign _144 = _42 ? _143 : _32;
    assign _9 = data$value;
    assign _136 = _9[33:0];
    assign _11 = data$valid;
    assign _137 = _11 ? _136 : _36;
    assign _133 = _114 ? _33 : _36;
    assign _134 = _47 ? _36 : _133;
    assign _126 = _114 ? gnd : _125;
    assign _97 = 34'b0000000000000000000000000000000001;
    assign _96 = _36 - _32;
    assign _98 = _96 + _97;
    assign _99 = _38 ? range : _98;
    assign _100 = _34 ? range : _99;
    assign _101 = _28 ? _100 : range;
    assign _12 = _101;
    always @(posedge _18) begin
        if (_16)
            range <= _33;
        else
            range <= _12;
    end
    assign _118 = range_counter + _97;
    assign _56 = _51 == gnd;
    assign _102 = _57 ? vdd : gnd;
    assign _103 = _47 ? _102 : gnd;
    assign _104 = _42 ? _103 : gnd;
    assign _105 = _38 ? _51 : _104;
    assign _106 = _34 ? _51 : _105;
    assign _107 = _28 ? _106 : _51;
    assign _13 = _107;
    always @(posedge _18) begin
        if (_16)
            _51 <= _68;
        else
            _51 <= _13;
    end
    assign gnd = 1'b0;
    assign _109 = _108 ? vdd : gnd;
    assign _110 = _38 ? _49 : _109;
    assign _111 = _34 ? _49 : _110;
    assign _112 = _28 ? _111 : _49;
    assign _14 = _112;
    always @(posedge _18) begin
        if (_16)
            _49 <= _68;
        else
            _49 <= _14;
    end
    assign _16 = reset;
    assign _18 = clock;
    bcd
        bcd
        ( .clock(_18),
          .reset(_16),
          .convert(_49),
          .start_value(_32),
          .increment(_51),
          .ready(_52[0:0]),
          .bcd_value(_52[44:1]),
          .int_value(_52[78:45]),
          .num_digits(_52[83:79]),
          .is_invalid(_52[84:84]) );
    assign _53 = _52[0:0];
    assign _54 = _53 == vdd;
    assign _57 = _54 & _56;
    assign _119 = _57 ? _118 : range_counter;
    assign _116 = _114 ? _33 : range_counter;
    assign _120 = _47 ? _119 : _116;
    assign _121 = _42 ? _120 : range_counter;
    assign _122 = _38 ? range_counter : _121;
    assign _123 = _34 ? range_counter : _122;
    assign _124 = _28 ? _123 : range_counter;
    assign _19 = _124;
    always @(posedge _18) begin
        if (_16)
            range_counter <= _33;
        else
            range_counter <= _19;
    end
    assign _47 = range_counter < range;
    assign _127 = _47 ? _125 : _126;
    assign vdd = 1'b1;
    assign _108 = ~ _40;
    assign _125 = _108 ? vdd : _40;
    assign _128 = _42 ? _127 : _125;
    assign _129 = _38 ? _40 : _128;
    assign _130 = _34 ? _40 : _129;
    assign _131 = _28 ? _130 : _40;
    assign _20 = _131;
    always @(posedge _18) begin
        if (_16)
            _40 <= _68;
        else
            _40 <= _20;
    end
    assign _42 = _40 == vdd;
    assign _135 = _42 ? _134 : _36;
    assign _138 = _38 ? _137 : _135;
    assign _139 = _34 ? _36 : _138;
    assign _140 = _28 ? _139 : _36;
    assign _21 = _140;
    always @(posedge _18) begin
        if (_16)
            _36 <= _33;
        else
            _36 <= _21;
    end
    assign _38 = _36 == _33;
    assign _145 = _38 ? _32 : _144;
    assign _148 = _34 ? _147 : _145;
    assign _149 = _28 ? _148 : _32;
    assign _22 = _149;
    always @(posedge _18) begin
        if (_16)
            _32 <= _33;
        else
            _32 <= _22;
    end
    assign _34 = _32 == _33;
    assign _153 = _34 ? _114 : _152;
    assign _27 = 5'b00100;
    assign _24 = puzzle;
    assign _28 = _24 == _27;
    assign _154 = _28 ? _153 : _114;
    assign _25 = _154;
    always @(posedge _18) begin
        if (_16)
            _114 <= _68;
        else
            _114 <= _25;
    end
    assign result$valid = _114;
    assign result$value = _90;
    assign data_ready = _69;
    assign debug = _30;

endmodule
module aoc_top (
    puzzle,
    data$value,
    data$valid,
    reset,
    clock,
    result$valid,
    result$value,
    data_ready,
    debug
);

    input [4:0] puzzle;
    input [63:0] data$value;
    input data$valid;
    input reset;
    input clock;
    output result$valid;
    output [63:0] result$value;
    output data_ready;
    output [1:0] debug;

    wire [1:0] _16;
    wire _17;
    wire [63:0] _18;
    wire [4:0] _5;
    wire [63:0] _7;
    wire _9;
    wire _11;
    wire _13;
    wire [67:0] _15;
    wire _19;
    assign _16 = _15[67:66];
    assign _17 = _15[65:65];
    assign _18 = _15[64:1];
    assign _5 = puzzle;
    assign _7 = data$value;
    assign _9 = data$valid;
    assign _11 = reset;
    assign _13 = clock;
    aoc
        aoc
        ( .clock(_13),
          .reset(_11),
          .data$valid(_9),
          .data$value(_7),
          .puzzle(_5),
          .result$valid(_15[0:0]),
          .result$value(_15[64:1]),
          .data_ready(_15[65:65]),
          .debug(_15[67:66]) );
    assign _19 = _15[0:0];
    assign result$valid = _19;
    assign result$value = _18;
    assign data_ready = _17;
    assign debug = _16;

endmodule

