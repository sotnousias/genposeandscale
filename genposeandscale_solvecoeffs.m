function [b1 b2 b3 b4 b5] = genposeandscale_solvecoeffs(B1, B2, B3, B4, B5, B6)
% GENPOSEANDSCALE_SOLVECOEFFS Solves for the coefficients of the basis vectors for the gp+s problem.
%   [b1 b2 b3 b4 b5] = genposeandscale_solvecoeffs(B1, B2, B3, B4, B5, B6)
%
% If you use this algorithm in your work, please cite the following paper:
% J. Ventura, C. Arth, G. Reitmayr, and D. Schmalstieg,
% "A Minimal Solution to the Generalized Pose-and-Scale Problem", CVPR, 2014.
% 
% Copyright (c) 2014 Graz University of Technology.
% 
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted (subject to the limitations in the disclaimer
% below) provided that the following conditions are met:
% 
%  * Redistributions of source code must retain the above copyright
%    notice, this list of conditions and the following disclaimer.
% 
%  * Redistributions in binary form must reproduce the above copyright
%    notice, this list of conditions and the following disclaimer in the
%    documentation and/or other materials provided with the distribution.
% 
%  * Neither the name of Graz University of Technology nor the names of its
%    contributors may be used to endorse or promote products derived from this
%    software without specific prior written permission.
% 
% NO EXPRESS OR IMPLIED LICENSES TO ANY PARTY'S PATENT RIGHTS ARE GRANTED BY THIS
% LICENSE.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
% "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
% THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
% FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
% DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
% OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%
% Generated using GBSolver generator Copyright Martin Bujnak,
% Zuzana Kukelova, Tomas Pajdla CTU Prague 2008.
% 
% Please refer to the following paper, when using this code :
%     Kukelova Z., Bujnak M., Pajdla T., Automatic Generator of Minimal Problem Solvers,
%     ECCV 2008, Marseille, France, October 12-18, 2008

	% precalculate polynomial equations coefficients
	c = zeros(210,1);
	c(1) = B1(1)^2 - B1(2)^2 + B1(4)^2 - B1(5)^2 + B1(7)^2 - B1(8)^2;
	c(2) = 2*B1(1)*B2(1) - 2*B1(2)*B2(2) + 2*B1(4)*B2(4) - 2*B1(5)*B2(5) + 2*B1(7)*B2(7) - 2*B1(8)*B2(8);
	c(3) = B2(1)^2 - B2(2)^2 + B2(4)^2 - B2(5)^2 + B2(7)^2 - B2(8)^2;
	c(4) = 2*B1(1)*B3(1) - 2*B1(2)*B3(2) + 2*B1(4)*B3(4) - 2*B1(5)*B3(5) + 2*B1(7)*B3(7) - 2*B1(8)*B3(8);
	c(5) = 2*B2(1)*B3(1) - 2*B2(2)*B3(2) + 2*B2(4)*B3(4) - 2*B2(5)*B3(5) + 2*B2(7)*B3(7) - 2*B2(8)*B3(8);
	c(6) = B3(1)^2 - B3(2)^2 + B3(4)^2 - B3(5)^2 + B3(7)^2 - B3(8)^2;
	c(7) = 2*B1(1)*B4(1) - 2*B1(2)*B4(2) + 2*B1(4)*B4(4) - 2*B1(5)*B4(5) + 2*B1(7)*B4(7) - 2*B1(8)*B4(8);
	c(8) = 2*B2(1)*B4(1) - 2*B2(2)*B4(2) + 2*B2(4)*B4(4) - 2*B2(5)*B4(5) + 2*B2(7)*B4(7) - 2*B2(8)*B4(8);
	c(9) = 2*B3(1)*B4(1) - 2*B3(2)*B4(2) + 2*B3(4)*B4(4) - 2*B3(5)*B4(5) + 2*B3(7)*B4(7) - 2*B3(8)*B4(8);
	c(10) = B4(1)^2 - B4(2)^2 + B4(4)^2 - B4(5)^2 + B4(7)^2 - B4(8)^2;
	c(11) = 2*B1(1)*B5(1) - 2*B1(2)*B5(2) + 2*B1(4)*B5(4) - 2*B1(5)*B5(5) + 2*B1(7)*B5(7) - 2*B1(8)*B5(8);
	c(12) = 2*B2(1)*B5(1) - 2*B2(2)*B5(2) + 2*B2(4)*B5(4) - 2*B2(5)*B5(5) + 2*B2(7)*B5(7) - 2*B2(8)*B5(8);
	c(13) = 2*B3(1)*B5(1) - 2*B3(2)*B5(2) + 2*B3(4)*B5(4) - 2*B3(5)*B5(5) + 2*B3(7)*B5(7) - 2*B3(8)*B5(8);
	c(14) = 2*B4(1)*B5(1) - 2*B4(2)*B5(2) + 2*B4(4)*B5(4) - 2*B4(5)*B5(5) + 2*B4(7)*B5(7) - 2*B4(8)*B5(8);
	c(15) = B5(1)^2 - B5(2)^2 + B5(4)^2 - B5(5)^2 + B5(7)^2 - B5(8)^2;
	c(16) = 2*B1(1)*B6(1) - 2*B1(2)*B6(2) + 2*B1(4)*B6(4) - 2*B1(5)*B6(5) + 2*B1(7)*B6(7) - 2*B1(8)*B6(8);
	c(17) = 2*B2(1)*B6(1) - 2*B2(2)*B6(2) + 2*B2(4)*B6(4) - 2*B2(5)*B6(5) + 2*B2(7)*B6(7) - 2*B2(8)*B6(8);
	c(18) = 2*B3(1)*B6(1) - 2*B3(2)*B6(2) + 2*B3(4)*B6(4) - 2*B3(5)*B6(5) + 2*B3(7)*B6(7) - 2*B3(8)*B6(8);
	c(19) = 2*B4(1)*B6(1) - 2*B4(2)*B6(2) + 2*B4(4)*B6(4) - 2*B4(5)*B6(5) + 2*B4(7)*B6(7) - 2*B4(8)*B6(8);
	c(20) = 2*B5(1)*B6(1) - 2*B5(2)*B6(2) + 2*B5(4)*B6(4) - 2*B5(5)*B6(5) + 2*B5(7)*B6(7) - 2*B5(8)*B6(8);
	c(21) = B6(1)^2 - B6(2)^2 + B6(4)^2 - B6(5)^2 + B6(7)^2 - B6(8)^2;
	c(22) = B1(1)^2 - B1(3)^2 + B1(4)^2 - B1(6)^2 + B1(7)^2 - B1(9)^2;
	c(23) = 2*B1(1)*B2(1) - 2*B1(3)*B2(3) + 2*B1(4)*B2(4) - 2*B1(6)*B2(6) + 2*B1(7)*B2(7) - 2*B1(9)*B2(9);
	c(24) = B2(1)^2 - B2(3)^2 + B2(4)^2 - B2(6)^2 + B2(7)^2 - B2(9)^2;
	c(25) = 2*B1(1)*B3(1) - 2*B1(3)*B3(3) + 2*B1(4)*B3(4) - 2*B1(6)*B3(6) + 2*B1(7)*B3(7) - 2*B1(9)*B3(9);
	c(26) = 2*B2(1)*B3(1) - 2*B2(3)*B3(3) + 2*B2(4)*B3(4) - 2*B2(6)*B3(6) + 2*B2(7)*B3(7) - 2*B2(9)*B3(9);
	c(27) = B3(1)^2 - B3(3)^2 + B3(4)^2 - B3(6)^2 + B3(7)^2 - B3(9)^2;
	c(28) = 2*B1(1)*B4(1) - 2*B1(3)*B4(3) + 2*B1(4)*B4(4) - 2*B1(6)*B4(6) + 2*B1(7)*B4(7) - 2*B1(9)*B4(9);
	c(29) = 2*B2(1)*B4(1) - 2*B2(3)*B4(3) + 2*B2(4)*B4(4) - 2*B2(6)*B4(6) + 2*B2(7)*B4(7) - 2*B2(9)*B4(9);
	c(30) = 2*B3(1)*B4(1) - 2*B3(3)*B4(3) + 2*B3(4)*B4(4) - 2*B3(6)*B4(6) + 2*B3(7)*B4(7) - 2*B3(9)*B4(9);
	c(31) = B4(1)^2 - B4(3)^2 + B4(4)^2 - B4(6)^2 + B4(7)^2 - B4(9)^2;
	c(32) = 2*B1(1)*B5(1) - 2*B1(3)*B5(3) + 2*B1(4)*B5(4) - 2*B1(6)*B5(6) + 2*B1(7)*B5(7) - 2*B1(9)*B5(9);
	c(33) = 2*B2(1)*B5(1) - 2*B2(3)*B5(3) + 2*B2(4)*B5(4) - 2*B2(6)*B5(6) + 2*B2(7)*B5(7) - 2*B2(9)*B5(9);
	c(34) = 2*B3(1)*B5(1) - 2*B3(3)*B5(3) + 2*B3(4)*B5(4) - 2*B3(6)*B5(6) + 2*B3(7)*B5(7) - 2*B3(9)*B5(9);
	c(35) = 2*B4(1)*B5(1) - 2*B4(3)*B5(3) + 2*B4(4)*B5(4) - 2*B4(6)*B5(6) + 2*B4(7)*B5(7) - 2*B4(9)*B5(9);
	c(36) = B5(1)^2 - B5(3)^2 + B5(4)^2 - B5(6)^2 + B5(7)^2 - B5(9)^2;
	c(37) = 2*B1(1)*B6(1) - 2*B1(3)*B6(3) + 2*B1(4)*B6(4) - 2*B1(6)*B6(6) + 2*B1(7)*B6(7) - 2*B1(9)*B6(9);
	c(38) = 2*B2(1)*B6(1) - 2*B2(3)*B6(3) + 2*B2(4)*B6(4) - 2*B2(6)*B6(6) + 2*B2(7)*B6(7) - 2*B2(9)*B6(9);
	c(39) = 2*B3(1)*B6(1) - 2*B3(3)*B6(3) + 2*B3(4)*B6(4) - 2*B3(6)*B6(6) + 2*B3(7)*B6(7) - 2*B3(9)*B6(9);
	c(40) = 2*B4(1)*B6(1) - 2*B4(3)*B6(3) + 2*B4(4)*B6(4) - 2*B4(6)*B6(6) + 2*B4(7)*B6(7) - 2*B4(9)*B6(9);
	c(41) = 2*B5(1)*B6(1) - 2*B5(3)*B6(3) + 2*B5(4)*B6(4) - 2*B5(6)*B6(6) + 2*B5(7)*B6(7) - 2*B5(9)*B6(9);
	c(42) = B6(1)^2 - B6(3)^2 + B6(4)^2 - B6(6)^2 + B6(7)^2 - B6(9)^2;
	c(43) = B1(1)^2 + B1(2)^2 + B1(3)^2 - B1(4)^2 - B1(5)^2 - B1(6)^2;
	c(44) = 2*B1(1)*B2(1) + 2*B1(2)*B2(2) + 2*B1(3)*B2(3) - 2*B1(4)*B2(4) - 2*B1(5)*B2(5) - 2*B1(6)*B2(6);
	c(45) = B2(1)^2 + B2(2)^2 + B2(3)^2 - B2(4)^2 - B2(5)^2 - B2(6)^2;
	c(46) = 2*B1(1)*B3(1) + 2*B1(2)*B3(2) + 2*B1(3)*B3(3) - 2*B1(4)*B3(4) - 2*B1(5)*B3(5) - 2*B1(6)*B3(6);
	c(47) = 2*B2(1)*B3(1) + 2*B2(2)*B3(2) + 2*B2(3)*B3(3) - 2*B2(4)*B3(4) - 2*B2(5)*B3(5) - 2*B2(6)*B3(6);
	c(48) = B3(1)^2 + B3(2)^2 + B3(3)^2 - B3(4)^2 - B3(5)^2 - B3(6)^2;
	c(49) = 2*B1(1)*B4(1) + 2*B1(2)*B4(2) + 2*B1(3)*B4(3) - 2*B1(4)*B4(4) - 2*B1(5)*B4(5) - 2*B1(6)*B4(6);
	c(50) = 2*B2(1)*B4(1) + 2*B2(2)*B4(2) + 2*B2(3)*B4(3) - 2*B2(4)*B4(4) - 2*B2(5)*B4(5) - 2*B2(6)*B4(6);
	c(51) = 2*B3(1)*B4(1) + 2*B3(2)*B4(2) + 2*B3(3)*B4(3) - 2*B3(4)*B4(4) - 2*B3(5)*B4(5) - 2*B3(6)*B4(6);
	c(52) = B4(1)^2 + B4(2)^2 + B4(3)^2 - B4(4)^2 - B4(5)^2 - B4(6)^2;
	c(53) = 2*B1(1)*B5(1) + 2*B1(2)*B5(2) + 2*B1(3)*B5(3) - 2*B1(4)*B5(4) - 2*B1(5)*B5(5) - 2*B1(6)*B5(6);
	c(54) = 2*B2(1)*B5(1) + 2*B2(2)*B5(2) + 2*B2(3)*B5(3) - 2*B2(4)*B5(4) - 2*B2(5)*B5(5) - 2*B2(6)*B5(6);
	c(55) = 2*B3(1)*B5(1) + 2*B3(2)*B5(2) + 2*B3(3)*B5(3) - 2*B3(4)*B5(4) - 2*B3(5)*B5(5) - 2*B3(6)*B5(6);
	c(56) = 2*B4(1)*B5(1) + 2*B4(2)*B5(2) + 2*B4(3)*B5(3) - 2*B4(4)*B5(4) - 2*B4(5)*B5(5) - 2*B4(6)*B5(6);
	c(57) = B5(1)^2 + B5(2)^2 + B5(3)^2 - B5(4)^2 - B5(5)^2 - B5(6)^2;
	c(58) = 2*B1(1)*B6(1) + 2*B1(2)*B6(2) + 2*B1(3)*B6(3) - 2*B1(4)*B6(4) - 2*B1(5)*B6(5) - 2*B1(6)*B6(6);
	c(59) = 2*B2(1)*B6(1) + 2*B2(2)*B6(2) + 2*B2(3)*B6(3) - 2*B2(4)*B6(4) - 2*B2(5)*B6(5) - 2*B2(6)*B6(6);
	c(60) = 2*B3(1)*B6(1) + 2*B3(2)*B6(2) + 2*B3(3)*B6(3) - 2*B3(4)*B6(4) - 2*B3(5)*B6(5) - 2*B3(6)*B6(6);
	c(61) = 2*B4(1)*B6(1) + 2*B4(2)*B6(2) + 2*B4(3)*B6(3) - 2*B4(4)*B6(4) - 2*B4(5)*B6(5) - 2*B4(6)*B6(6);
	c(62) = 2*B5(1)*B6(1) + 2*B5(2)*B6(2) + 2*B5(3)*B6(3) - 2*B5(4)*B6(4) - 2*B5(5)*B6(5) - 2*B5(6)*B6(6);
	c(63) = B6(1)^2 + B6(2)^2 + B6(3)^2 - B6(4)^2 - B6(5)^2 - B6(6)^2;
	c(64) = B1(1)^2 + B1(2)^2 + B1(3)^2 - B1(7)^2 - B1(8)^2 - B1(9)^2;
	c(65) = 2*B1(1)*B2(1) + 2*B1(2)*B2(2) + 2*B1(3)*B2(3) - 2*B1(7)*B2(7) - 2*B1(8)*B2(8) - 2*B1(9)*B2(9);
	c(66) = B2(1)^2 + B2(2)^2 + B2(3)^2 - B2(7)^2 - B2(8)^2 - B2(9)^2;
	c(67) = 2*B1(1)*B3(1) + 2*B1(2)*B3(2) + 2*B1(3)*B3(3) - 2*B1(7)*B3(7) - 2*B1(8)*B3(8) - 2*B1(9)*B3(9);
	c(68) = 2*B2(1)*B3(1) + 2*B2(2)*B3(2) + 2*B2(3)*B3(3) - 2*B2(7)*B3(7) - 2*B2(8)*B3(8) - 2*B2(9)*B3(9);
	c(69) = B3(1)^2 + B3(2)^2 + B3(3)^2 - B3(7)^2 - B3(8)^2 - B3(9)^2;
	c(70) = 2*B1(1)*B4(1) + 2*B1(2)*B4(2) + 2*B1(3)*B4(3) - 2*B1(7)*B4(7) - 2*B1(8)*B4(8) - 2*B1(9)*B4(9);
	c(71) = 2*B2(1)*B4(1) + 2*B2(2)*B4(2) + 2*B2(3)*B4(3) - 2*B2(7)*B4(7) - 2*B2(8)*B4(8) - 2*B2(9)*B4(9);
	c(72) = 2*B3(1)*B4(1) + 2*B3(2)*B4(2) + 2*B3(3)*B4(3) - 2*B3(7)*B4(7) - 2*B3(8)*B4(8) - 2*B3(9)*B4(9);
	c(73) = B4(1)^2 + B4(2)^2 + B4(3)^2 - B4(7)^2 - B4(8)^2 - B4(9)^2;
	c(74) = 2*B1(1)*B5(1) + 2*B1(2)*B5(2) + 2*B1(3)*B5(3) - 2*B1(7)*B5(7) - 2*B1(8)*B5(8) - 2*B1(9)*B5(9);
	c(75) = 2*B2(1)*B5(1) + 2*B2(2)*B5(2) + 2*B2(3)*B5(3) - 2*B2(7)*B5(7) - 2*B2(8)*B5(8) - 2*B2(9)*B5(9);
	c(76) = 2*B3(1)*B5(1) + 2*B3(2)*B5(2) + 2*B3(3)*B5(3) - 2*B3(7)*B5(7) - 2*B3(8)*B5(8) - 2*B3(9)*B5(9);
	c(77) = 2*B4(1)*B5(1) + 2*B4(2)*B5(2) + 2*B4(3)*B5(3) - 2*B4(7)*B5(7) - 2*B4(8)*B5(8) - 2*B4(9)*B5(9);
	c(78) = B5(1)^2 + B5(2)^2 + B5(3)^2 - B5(7)^2 - B5(8)^2 - B5(9)^2;
	c(79) = 2*B1(1)*B6(1) + 2*B1(2)*B6(2) + 2*B1(3)*B6(3) - 2*B1(7)*B6(7) - 2*B1(8)*B6(8) - 2*B1(9)*B6(9);
	c(80) = 2*B2(1)*B6(1) + 2*B2(2)*B6(2) + 2*B2(3)*B6(3) - 2*B2(7)*B6(7) - 2*B2(8)*B6(8) - 2*B2(9)*B6(9);
	c(81) = 2*B3(1)*B6(1) + 2*B3(2)*B6(2) + 2*B3(3)*B6(3) - 2*B3(7)*B6(7) - 2*B3(8)*B6(8) - 2*B3(9)*B6(9);
	c(82) = 2*B4(1)*B6(1) + 2*B4(2)*B6(2) + 2*B4(3)*B6(3) - 2*B4(7)*B6(7) - 2*B4(8)*B6(8) - 2*B4(9)*B6(9);
	c(83) = 2*B5(1)*B6(1) + 2*B5(2)*B6(2) + 2*B5(3)*B6(3) - 2*B5(7)*B6(7) - 2*B5(8)*B6(8) - 2*B5(9)*B6(9);
	c(84) = B6(1)^2 + B6(2)^2 + B6(3)^2 - B6(7)^2 - B6(8)^2 - B6(9)^2;
	c(85) = B1(1)*B1(2) + B1(4)*B1(5) + B1(7)*B1(8);
	c(86) = B1(1)*B2(2) + B1(2)*B2(1) + B1(4)*B2(5) + B1(5)*B2(4) + B1(7)*B2(8) + B1(8)*B2(7);
	c(87) = B2(1)*B2(2) + B2(4)*B2(5) + B2(7)*B2(8);
	c(88) = B1(1)*B3(2) + B1(2)*B3(1) + B1(4)*B3(5) + B1(5)*B3(4) + B1(7)*B3(8) + B1(8)*B3(7);
	c(89) = B2(1)*B3(2) + B2(2)*B3(1) + B2(4)*B3(5) + B2(5)*B3(4) + B2(7)*B3(8) + B2(8)*B3(7);
	c(90) = B3(1)*B3(2) + B3(4)*B3(5) + B3(7)*B3(8);
	c(91) = B1(1)*B4(2) + B1(2)*B4(1) + B1(4)*B4(5) + B1(5)*B4(4) + B1(7)*B4(8) + B1(8)*B4(7);
	c(92) = B2(1)*B4(2) + B2(2)*B4(1) + B2(4)*B4(5) + B2(5)*B4(4) + B2(7)*B4(8) + B2(8)*B4(7);
	c(93) = B3(1)*B4(2) + B3(2)*B4(1) + B3(4)*B4(5) + B3(5)*B4(4) + B3(7)*B4(8) + B3(8)*B4(7);
	c(94) = B4(1)*B4(2) + B4(4)*B4(5) + B4(7)*B4(8);
	c(95) = B1(1)*B5(2) + B1(2)*B5(1) + B1(4)*B5(5) + B1(5)*B5(4) + B1(7)*B5(8) + B1(8)*B5(7);
	c(96) = B2(1)*B5(2) + B2(2)*B5(1) + B2(4)*B5(5) + B2(5)*B5(4) + B2(7)*B5(8) + B2(8)*B5(7);
	c(97) = B3(1)*B5(2) + B3(2)*B5(1) + B3(4)*B5(5) + B3(5)*B5(4) + B3(7)*B5(8) + B3(8)*B5(7);
	c(98) = B4(1)*B5(2) + B4(2)*B5(1) + B4(4)*B5(5) + B4(5)*B5(4) + B4(7)*B5(8) + B4(8)*B5(7);
	c(99) = B5(1)*B5(2) + B5(4)*B5(5) + B5(7)*B5(8);
	c(100) = B1(1)*B6(2) + B1(2)*B6(1) + B1(4)*B6(5) + B1(5)*B6(4) + B1(7)*B6(8) + B1(8)*B6(7);
	c(101) = B2(1)*B6(2) + B2(2)*B6(1) + B2(4)*B6(5) + B2(5)*B6(4) + B2(7)*B6(8) + B2(8)*B6(7);
	c(102) = B3(1)*B6(2) + B3(2)*B6(1) + B3(4)*B6(5) + B3(5)*B6(4) + B3(7)*B6(8) + B3(8)*B6(7);
	c(103) = B4(1)*B6(2) + B4(2)*B6(1) + B4(4)*B6(5) + B4(5)*B6(4) + B4(7)*B6(8) + B4(8)*B6(7);
	c(104) = B5(1)*B6(2) + B5(2)*B6(1) + B5(4)*B6(5) + B5(5)*B6(4) + B5(7)*B6(8) + B5(8)*B6(7);
	c(105) = B6(1)*B6(2) + B6(4)*B6(5) + B6(7)*B6(8);
	c(106) = B1(1)*B1(3) + B1(4)*B1(6) + B1(7)*B1(9);
	c(107) = B1(1)*B2(3) + B1(3)*B2(1) + B1(4)*B2(6) + B1(6)*B2(4) + B1(7)*B2(9) + B1(9)*B2(7);
	c(108) = B2(1)*B2(3) + B2(4)*B2(6) + B2(7)*B2(9);
	c(109) = B1(1)*B3(3) + B1(3)*B3(1) + B1(4)*B3(6) + B1(6)*B3(4) + B1(7)*B3(9) + B1(9)*B3(7);
	c(110) = B2(1)*B3(3) + B2(3)*B3(1) + B2(4)*B3(6) + B2(6)*B3(4) + B2(7)*B3(9) + B2(9)*B3(7);
	c(111) = B3(1)*B3(3) + B3(4)*B3(6) + B3(7)*B3(9);
	c(112) = B1(1)*B4(3) + B1(3)*B4(1) + B1(4)*B4(6) + B1(6)*B4(4) + B1(7)*B4(9) + B1(9)*B4(7);
	c(113) = B2(1)*B4(3) + B2(3)*B4(1) + B2(4)*B4(6) + B2(6)*B4(4) + B2(7)*B4(9) + B2(9)*B4(7);
	c(114) = B3(1)*B4(3) + B3(3)*B4(1) + B3(4)*B4(6) + B3(6)*B4(4) + B3(7)*B4(9) + B3(9)*B4(7);
	c(115) = B4(1)*B4(3) + B4(4)*B4(6) + B4(7)*B4(9);
	c(116) = B1(1)*B5(3) + B1(3)*B5(1) + B1(4)*B5(6) + B1(6)*B5(4) + B1(7)*B5(9) + B1(9)*B5(7);
	c(117) = B2(1)*B5(3) + B2(3)*B5(1) + B2(4)*B5(6) + B2(6)*B5(4) + B2(7)*B5(9) + B2(9)*B5(7);
	c(118) = B3(1)*B5(3) + B3(3)*B5(1) + B3(4)*B5(6) + B3(6)*B5(4) + B3(7)*B5(9) + B3(9)*B5(7);
	c(119) = B4(1)*B5(3) + B4(3)*B5(1) + B4(4)*B5(6) + B4(6)*B5(4) + B4(7)*B5(9) + B4(9)*B5(7);
	c(120) = B5(1)*B5(3) + B5(4)*B5(6) + B5(7)*B5(9);
	c(121) = B1(1)*B6(3) + B1(3)*B6(1) + B1(4)*B6(6) + B1(6)*B6(4) + B1(7)*B6(9) + B1(9)*B6(7);
	c(122) = B2(1)*B6(3) + B2(3)*B6(1) + B2(4)*B6(6) + B2(6)*B6(4) + B2(7)*B6(9) + B2(9)*B6(7);
	c(123) = B3(1)*B6(3) + B3(3)*B6(1) + B3(4)*B6(6) + B3(6)*B6(4) + B3(7)*B6(9) + B3(9)*B6(7);
	c(124) = B4(1)*B6(3) + B4(3)*B6(1) + B4(4)*B6(6) + B4(6)*B6(4) + B4(7)*B6(9) + B4(9)*B6(7);
	c(125) = B5(1)*B6(3) + B5(3)*B6(1) + B5(4)*B6(6) + B5(6)*B6(4) + B5(7)*B6(9) + B5(9)*B6(7);
	c(126) = B6(1)*B6(3) + B6(4)*B6(6) + B6(7)*B6(9);
	c(127) = B1(2)*B1(3) + B1(5)*B1(6) + B1(8)*B1(9);
	c(128) = B1(2)*B2(3) + B1(3)*B2(2) + B1(5)*B2(6) + B1(6)*B2(5) + B1(8)*B2(9) + B1(9)*B2(8);
	c(129) = B2(2)*B2(3) + B2(5)*B2(6) + B2(8)*B2(9);
	c(130) = B1(2)*B3(3) + B1(3)*B3(2) + B1(5)*B3(6) + B1(6)*B3(5) + B1(8)*B3(9) + B1(9)*B3(8);
	c(131) = B2(2)*B3(3) + B2(3)*B3(2) + B2(5)*B3(6) + B2(6)*B3(5) + B2(8)*B3(9) + B2(9)*B3(8);
	c(132) = B3(2)*B3(3) + B3(5)*B3(6) + B3(8)*B3(9);
	c(133) = B1(2)*B4(3) + B1(3)*B4(2) + B1(5)*B4(6) + B1(6)*B4(5) + B1(8)*B4(9) + B1(9)*B4(8);
	c(134) = B2(2)*B4(3) + B2(3)*B4(2) + B2(5)*B4(6) + B2(6)*B4(5) + B2(8)*B4(9) + B2(9)*B4(8);
	c(135) = B3(2)*B4(3) + B3(3)*B4(2) + B3(5)*B4(6) + B3(6)*B4(5) + B3(8)*B4(9) + B3(9)*B4(8);
	c(136) = B4(2)*B4(3) + B4(5)*B4(6) + B4(8)*B4(9);
	c(137) = B1(2)*B5(3) + B1(3)*B5(2) + B1(5)*B5(6) + B1(6)*B5(5) + B1(8)*B5(9) + B1(9)*B5(8);
	c(138) = B2(2)*B5(3) + B2(3)*B5(2) + B2(5)*B5(6) + B2(6)*B5(5) + B2(8)*B5(9) + B2(9)*B5(8);
	c(139) = B3(2)*B5(3) + B3(3)*B5(2) + B3(5)*B5(6) + B3(6)*B5(5) + B3(8)*B5(9) + B3(9)*B5(8);
	c(140) = B4(2)*B5(3) + B4(3)*B5(2) + B4(5)*B5(6) + B4(6)*B5(5) + B4(8)*B5(9) + B4(9)*B5(8);
	c(141) = B5(2)*B5(3) + B5(5)*B5(6) + B5(8)*B5(9);
	c(142) = B1(2)*B6(3) + B1(3)*B6(2) + B1(5)*B6(6) + B1(6)*B6(5) + B1(8)*B6(9) + B1(9)*B6(8);
	c(143) = B2(2)*B6(3) + B2(3)*B6(2) + B2(5)*B6(6) + B2(6)*B6(5) + B2(8)*B6(9) + B2(9)*B6(8);
	c(144) = B3(2)*B6(3) + B3(3)*B6(2) + B3(5)*B6(6) + B3(6)*B6(5) + B3(8)*B6(9) + B3(9)*B6(8);
	c(145) = B4(2)*B6(3) + B4(3)*B6(2) + B4(5)*B6(6) + B4(6)*B6(5) + B4(8)*B6(9) + B4(9)*B6(8);
	c(146) = B5(2)*B6(3) + B5(3)*B6(2) + B5(5)*B6(6) + B5(6)*B6(5) + B5(8)*B6(9) + B5(9)*B6(8);
	c(147) = B6(2)*B6(3) + B6(5)*B6(6) + B6(8)*B6(9);
	c(148) = B1(1)*B1(4) + B1(2)*B1(5) + B1(3)*B1(6);
	c(149) = B1(1)*B2(4) + B1(4)*B2(1) + B1(2)*B2(5) + B1(5)*B2(2) + B1(3)*B2(6) + B1(6)*B2(3);
	c(150) = B2(1)*B2(4) + B2(2)*B2(5) + B2(3)*B2(6);
	c(151) = B1(1)*B3(4) + B1(4)*B3(1) + B1(2)*B3(5) + B1(5)*B3(2) + B1(3)*B3(6) + B1(6)*B3(3);
	c(152) = B2(1)*B3(4) + B2(4)*B3(1) + B2(2)*B3(5) + B2(5)*B3(2) + B2(3)*B3(6) + B2(6)*B3(3);
	c(153) = B3(1)*B3(4) + B3(2)*B3(5) + B3(3)*B3(6);
	c(154) = B1(1)*B4(4) + B1(4)*B4(1) + B1(2)*B4(5) + B1(5)*B4(2) + B1(3)*B4(6) + B1(6)*B4(3);
	c(155) = B2(1)*B4(4) + B2(4)*B4(1) + B2(2)*B4(5) + B2(5)*B4(2) + B2(3)*B4(6) + B2(6)*B4(3);
	c(156) = B3(1)*B4(4) + B3(4)*B4(1) + B3(2)*B4(5) + B3(5)*B4(2) + B3(3)*B4(6) + B3(6)*B4(3);
	c(157) = B4(1)*B4(4) + B4(2)*B4(5) + B4(3)*B4(6);
	c(158) = B1(1)*B5(4) + B1(4)*B5(1) + B1(2)*B5(5) + B1(5)*B5(2) + B1(3)*B5(6) + B1(6)*B5(3);
	c(159) = B2(1)*B5(4) + B2(4)*B5(1) + B2(2)*B5(5) + B2(5)*B5(2) + B2(3)*B5(6) + B2(6)*B5(3);
	c(160) = B3(1)*B5(4) + B3(4)*B5(1) + B3(2)*B5(5) + B3(5)*B5(2) + B3(3)*B5(6) + B3(6)*B5(3);
	c(161) = B4(1)*B5(4) + B4(4)*B5(1) + B4(2)*B5(5) + B4(5)*B5(2) + B4(3)*B5(6) + B4(6)*B5(3);
	c(162) = B5(1)*B5(4) + B5(2)*B5(5) + B5(3)*B5(6);
	c(163) = B1(1)*B6(4) + B1(4)*B6(1) + B1(2)*B6(5) + B1(5)*B6(2) + B1(3)*B6(6) + B1(6)*B6(3);
	c(164) = B2(1)*B6(4) + B2(4)*B6(1) + B2(2)*B6(5) + B2(5)*B6(2) + B2(3)*B6(6) + B2(6)*B6(3);
	c(165) = B3(1)*B6(4) + B3(4)*B6(1) + B3(2)*B6(5) + B3(5)*B6(2) + B3(3)*B6(6) + B3(6)*B6(3);
	c(166) = B4(1)*B6(4) + B4(4)*B6(1) + B4(2)*B6(5) + B4(5)*B6(2) + B4(3)*B6(6) + B4(6)*B6(3);
	c(167) = B5(1)*B6(4) + B5(4)*B6(1) + B5(2)*B6(5) + B5(5)*B6(2) + B5(3)*B6(6) + B5(6)*B6(3);
	c(168) = B6(1)*B6(4) + B6(2)*B6(5) + B6(3)*B6(6);
	c(169) = B1(1)*B1(7) + B1(2)*B1(8) + B1(3)*B1(9);
	c(170) = B1(1)*B2(7) + B1(7)*B2(1) + B1(2)*B2(8) + B1(8)*B2(2) + B1(3)*B2(9) + B1(9)*B2(3);
	c(171) = B2(1)*B2(7) + B2(2)*B2(8) + B2(3)*B2(9);
	c(172) = B1(1)*B3(7) + B1(7)*B3(1) + B1(2)*B3(8) + B1(8)*B3(2) + B1(3)*B3(9) + B1(9)*B3(3);
	c(173) = B2(1)*B3(7) + B2(7)*B3(1) + B2(2)*B3(8) + B2(8)*B3(2) + B2(3)*B3(9) + B2(9)*B3(3);
	c(174) = B3(1)*B3(7) + B3(2)*B3(8) + B3(3)*B3(9);
	c(175) = B1(1)*B4(7) + B1(7)*B4(1) + B1(2)*B4(8) + B1(8)*B4(2) + B1(3)*B4(9) + B1(9)*B4(3);
	c(176) = B2(1)*B4(7) + B2(7)*B4(1) + B2(2)*B4(8) + B2(8)*B4(2) + B2(3)*B4(9) + B2(9)*B4(3);
	c(177) = B3(1)*B4(7) + B3(7)*B4(1) + B3(2)*B4(8) + B3(8)*B4(2) + B3(3)*B4(9) + B3(9)*B4(3);
	c(178) = B4(1)*B4(7) + B4(2)*B4(8) + B4(3)*B4(9);
	c(179) = B1(1)*B5(7) + B1(7)*B5(1) + B1(2)*B5(8) + B1(8)*B5(2) + B1(3)*B5(9) + B1(9)*B5(3);
	c(180) = B2(1)*B5(7) + B2(7)*B5(1) + B2(2)*B5(8) + B2(8)*B5(2) + B2(3)*B5(9) + B2(9)*B5(3);
	c(181) = B3(1)*B5(7) + B3(7)*B5(1) + B3(2)*B5(8) + B3(8)*B5(2) + B3(3)*B5(9) + B3(9)*B5(3);
	c(182) = B4(1)*B5(7) + B4(7)*B5(1) + B4(2)*B5(8) + B4(8)*B5(2) + B4(3)*B5(9) + B4(9)*B5(3);
	c(183) = B5(1)*B5(7) + B5(2)*B5(8) + B5(3)*B5(9);
	c(184) = B1(1)*B6(7) + B1(7)*B6(1) + B1(2)*B6(8) + B1(8)*B6(2) + B1(3)*B6(9) + B1(9)*B6(3);
	c(185) = B2(1)*B6(7) + B2(7)*B6(1) + B2(2)*B6(8) + B2(8)*B6(2) + B2(3)*B6(9) + B2(9)*B6(3);
	c(186) = B3(1)*B6(7) + B3(7)*B6(1) + B3(2)*B6(8) + B3(8)*B6(2) + B3(3)*B6(9) + B3(9)*B6(3);
	c(187) = B4(1)*B6(7) + B4(7)*B6(1) + B4(2)*B6(8) + B4(8)*B6(2) + B4(3)*B6(9) + B4(9)*B6(3);
	c(188) = B5(1)*B6(7) + B5(7)*B6(1) + B5(2)*B6(8) + B5(8)*B6(2) + B5(3)*B6(9) + B5(9)*B6(3);
	c(189) = B6(1)*B6(7) + B6(2)*B6(8) + B6(3)*B6(9);
	c(190) = B1(4)*B1(7) + B1(5)*B1(8) + B1(6)*B1(9);
	c(191) = B1(4)*B2(7) + B1(7)*B2(4) + B1(5)*B2(8) + B1(8)*B2(5) + B1(6)*B2(9) + B1(9)*B2(6);
	c(192) = B2(4)*B2(7) + B2(5)*B2(8) + B2(6)*B2(9);
	c(193) = B1(4)*B3(7) + B1(7)*B3(4) + B1(5)*B3(8) + B1(8)*B3(5) + B1(6)*B3(9) + B1(9)*B3(6);
	c(194) = B2(4)*B3(7) + B2(7)*B3(4) + B2(5)*B3(8) + B2(8)*B3(5) + B2(6)*B3(9) + B2(9)*B3(6);
	c(195) = B3(4)*B3(7) + B3(5)*B3(8) + B3(6)*B3(9);
	c(196) = B1(4)*B4(7) + B1(7)*B4(4) + B1(5)*B4(8) + B1(8)*B4(5) + B1(6)*B4(9) + B1(9)*B4(6);
	c(197) = B2(4)*B4(7) + B2(7)*B4(4) + B2(5)*B4(8) + B2(8)*B4(5) + B2(6)*B4(9) + B2(9)*B4(6);
	c(198) = B3(4)*B4(7) + B3(7)*B4(4) + B3(5)*B4(8) + B3(8)*B4(5) + B3(6)*B4(9) + B3(9)*B4(6);
	c(199) = B4(4)*B4(7) + B4(5)*B4(8) + B4(6)*B4(9);
	c(200) = B1(4)*B5(7) + B1(7)*B5(4) + B1(5)*B5(8) + B1(8)*B5(5) + B1(6)*B5(9) + B1(9)*B5(6);
	c(201) = B2(4)*B5(7) + B2(7)*B5(4) + B2(5)*B5(8) + B2(8)*B5(5) + B2(6)*B5(9) + B2(9)*B5(6);
	c(202) = B3(4)*B5(7) + B3(7)*B5(4) + B3(5)*B5(8) + B3(8)*B5(5) + B3(6)*B5(9) + B3(9)*B5(6);
	c(203) = B4(4)*B5(7) + B4(7)*B5(4) + B4(5)*B5(8) + B4(8)*B5(5) + B4(6)*B5(9) + B4(9)*B5(6);
	c(204) = B5(4)*B5(7) + B5(5)*B5(8) + B5(6)*B5(9);
	c(205) = B1(4)*B6(7) + B1(7)*B6(4) + B1(5)*B6(8) + B1(8)*B6(5) + B1(6)*B6(9) + B1(9)*B6(6);
	c(206) = B2(4)*B6(7) + B2(7)*B6(4) + B2(5)*B6(8) + B2(8)*B6(5) + B2(6)*B6(9) + B2(9)*B6(6);
	c(207) = B3(4)*B6(7) + B3(7)*B6(4) + B3(5)*B6(8) + B3(8)*B6(5) + B3(6)*B6(9) + B3(9)*B6(6);
	c(208) = B4(4)*B6(7) + B4(7)*B6(4) + B4(5)*B6(8) + B4(8)*B6(5) + B4(6)*B6(9) + B4(9)*B6(6);
	c(209) = B5(4)*B6(7) + B5(7)*B6(4) + B5(5)*B6(8) + B5(8)*B6(5) + B5(6)*B6(9) + B5(9)*B6(6);
	c(210) = B6(4)*B6(7) + B6(5)*B6(8) + B6(6)*B6(9);

	M = zeros(48, 56);
	ci = [15, 62, 205, 492, 971, 1681];
	M(ci) = c(1);

	ci = [63, 110, 253, 540, 1019, 1729];
	M(ci) = c(2);

	ci = [111, 158, 301, 588, 1067, 1777];
	M(ci) = c(3);

	ci = [207, 254, 349, 636, 1115, 1825];
	M(ci) = c(4);

	ci = [255, 302, 397, 684, 1163, 1873];
	M(ci) = c(5);

	ci = [351, 398, 445, 732, 1211, 1921];
	M(ci) = c(6);

	ci = [495, 542, 637, 780, 1259, 1969];
	M(ci) = c(7);

	ci = [543, 590, 685, 828, 1307, 2017];
	M(ci) = c(8);

	ci = [639, 686, 733, 876, 1355, 2065];
	M(ci) = c(9);

	ci = [783, 830, 877, 924, 1403, 2113];
	M(ci) = c(10);

	ci = [975, 1022, 1117, 1260, 1451, 2161];
	M(ci) = c(11);

	ci = [1023, 1070, 1165, 1308, 1499, 2209];
	M(ci) = c(12);

	ci = [1119, 1166, 1213, 1356, 1547, 2257];
	M(ci) = c(13);

	ci = [1263, 1310, 1357, 1404, 1595, 2305];
	M(ci) = c(14);

	ci = [1455, 1502, 1549, 1596, 1643, 2353];
	M(ci) = c(15);

	ci = [1695, 1742, 1837, 1980, 2171, 2401];
	M(ci) = c(16);

	ci = [1743, 1790, 1885, 2028, 2219, 2449];
	M(ci) = c(17);

	ci = [1839, 1886, 1933, 2076, 2267, 2497];
	M(ci) = c(18);

	ci = [1983, 2030, 2077, 2124, 2315, 2545];
	M(ci) = c(19);

	ci = [2175, 2222, 2269, 2316, 2363, 2593];
	M(ci) = c(20);

	ci = [2415, 2462, 2509, 2556, 2603, 2641];
	M(ci) = c(21);

	ci = [20, 67, 210, 497, 976, 1682];
	M(ci) = c(22);

	ci = [68, 115, 258, 545, 1024, 1730];
	M(ci) = c(23);

	ci = [116, 163, 306, 593, 1072, 1778];
	M(ci) = c(24);

	ci = [212, 259, 354, 641, 1120, 1826];
	M(ci) = c(25);

	ci = [260, 307, 402, 689, 1168, 1874];
	M(ci) = c(26);

	ci = [356, 403, 450, 737, 1216, 1922];
	M(ci) = c(27);

	ci = [500, 547, 642, 785, 1264, 1970];
	M(ci) = c(28);

	ci = [548, 595, 690, 833, 1312, 2018];
	M(ci) = c(29);

	ci = [644, 691, 738, 881, 1360, 2066];
	M(ci) = c(30);

	ci = [788, 835, 882, 929, 1408, 2114];
	M(ci) = c(31);

	ci = [980, 1027, 1122, 1265, 1456, 2162];
	M(ci) = c(32);

	ci = [1028, 1075, 1170, 1313, 1504, 2210];
	M(ci) = c(33);

	ci = [1124, 1171, 1218, 1361, 1552, 2258];
	M(ci) = c(34);

	ci = [1268, 1315, 1362, 1409, 1600, 2306];
	M(ci) = c(35);

	ci = [1460, 1507, 1554, 1601, 1648, 2354];
	M(ci) = c(36);

	ci = [1700, 1747, 1842, 1985, 2176, 2402];
	M(ci) = c(37);

	ci = [1748, 1795, 1890, 2033, 2224, 2450];
	M(ci) = c(38);

	ci = [1844, 1891, 1938, 2081, 2272, 2498];
	M(ci) = c(39);

	ci = [1988, 2035, 2082, 2129, 2320, 2546];
	M(ci) = c(40);

	ci = [2180, 2227, 2274, 2321, 2368, 2594];
	M(ci) = c(41);

	ci = [2420, 2467, 2514, 2561, 2608, 2642];
	M(ci) = c(42);

	ci = [25, 72, 215, 502, 981, 1683];
	M(ci) = c(43);

	ci = [73, 120, 263, 550, 1029, 1731];
	M(ci) = c(44);

	ci = [121, 168, 311, 598, 1077, 1779];
	M(ci) = c(45);

	ci = [217, 264, 359, 646, 1125, 1827];
	M(ci) = c(46);

	ci = [265, 312, 407, 694, 1173, 1875];
	M(ci) = c(47);

	ci = [361, 408, 455, 742, 1221, 1923];
	M(ci) = c(48);

	ci = [505, 552, 647, 790, 1269, 1971];
	M(ci) = c(49);

	ci = [553, 600, 695, 838, 1317, 2019];
	M(ci) = c(50);

	ci = [649, 696, 743, 886, 1365, 2067];
	M(ci) = c(51);

	ci = [793, 840, 887, 934, 1413, 2115];
	M(ci) = c(52);

	ci = [985, 1032, 1127, 1270, 1461, 2163];
	M(ci) = c(53);

	ci = [1033, 1080, 1175, 1318, 1509, 2211];
	M(ci) = c(54);

	ci = [1129, 1176, 1223, 1366, 1557, 2259];
	M(ci) = c(55);

	ci = [1273, 1320, 1367, 1414, 1605, 2307];
	M(ci) = c(56);

	ci = [1465, 1512, 1559, 1606, 1653, 2355];
	M(ci) = c(57);

	ci = [1705, 1752, 1847, 1990, 2181, 2403];
	M(ci) = c(58);

	ci = [1753, 1800, 1895, 2038, 2229, 2451];
	M(ci) = c(59);

	ci = [1849, 1896, 1943, 2086, 2277, 2499];
	M(ci) = c(60);

	ci = [1993, 2040, 2087, 2134, 2325, 2547];
	M(ci) = c(61);

	ci = [2185, 2232, 2279, 2326, 2373, 2595];
	M(ci) = c(62);

	ci = [2425, 2472, 2519, 2566, 2613, 2643];
	M(ci) = c(63);

	ci = [30, 77, 220, 507, 986, 1684];
	M(ci) = c(64);

	ci = [78, 125, 268, 555, 1034, 1732];
	M(ci) = c(65);

	ci = [126, 173, 316, 603, 1082, 1780];
	M(ci) = c(66);

	ci = [222, 269, 364, 651, 1130, 1828];
	M(ci) = c(67);

	ci = [270, 317, 412, 699, 1178, 1876];
	M(ci) = c(68);

	ci = [366, 413, 460, 747, 1226, 1924];
	M(ci) = c(69);

	ci = [510, 557, 652, 795, 1274, 1972];
	M(ci) = c(70);

	ci = [558, 605, 700, 843, 1322, 2020];
	M(ci) = c(71);

	ci = [654, 701, 748, 891, 1370, 2068];
	M(ci) = c(72);

	ci = [798, 845, 892, 939, 1418, 2116];
	M(ci) = c(73);

	ci = [990, 1037, 1132, 1275, 1466, 2164];
	M(ci) = c(74);

	ci = [1038, 1085, 1180, 1323, 1514, 2212];
	M(ci) = c(75);

	ci = [1134, 1181, 1228, 1371, 1562, 2260];
	M(ci) = c(76);

	ci = [1278, 1325, 1372, 1419, 1610, 2308];
	M(ci) = c(77);

	ci = [1470, 1517, 1564, 1611, 1658, 2356];
	M(ci) = c(78);

	ci = [1710, 1757, 1852, 1995, 2186, 2404];
	M(ci) = c(79);

	ci = [1758, 1805, 1900, 2043, 2234, 2452];
	M(ci) = c(80);

	ci = [1854, 1901, 1948, 2091, 2282, 2500];
	M(ci) = c(81);

	ci = [1998, 2045, 2092, 2139, 2330, 2548];
	M(ci) = c(82);

	ci = [2190, 2237, 2284, 2331, 2378, 2596];
	M(ci) = c(83);

	ci = [2430, 2477, 2524, 2571, 2618, 2644];
	M(ci) = c(84);

	ci = [35, 82, 225, 512, 991, 1685];
	M(ci) = c(85);

	ci = [83, 130, 273, 560, 1039, 1733];
	M(ci) = c(86);

	ci = [131, 178, 321, 608, 1087, 1781];
	M(ci) = c(87);

	ci = [227, 274, 369, 656, 1135, 1829];
	M(ci) = c(88);

	ci = [275, 322, 417, 704, 1183, 1877];
	M(ci) = c(89);

	ci = [371, 418, 465, 752, 1231, 1925];
	M(ci) = c(90);

	ci = [515, 562, 657, 800, 1279, 1973];
	M(ci) = c(91);

	ci = [563, 610, 705, 848, 1327, 2021];
	M(ci) = c(92);

	ci = [659, 706, 753, 896, 1375, 2069];
	M(ci) = c(93);

	ci = [803, 850, 897, 944, 1423, 2117];
	M(ci) = c(94);

	ci = [995, 1042, 1137, 1280, 1471, 2165];
	M(ci) = c(95);

	ci = [1043, 1090, 1185, 1328, 1519, 2213];
	M(ci) = c(96);

	ci = [1139, 1186, 1233, 1376, 1567, 2261];
	M(ci) = c(97);

	ci = [1283, 1330, 1377, 1424, 1615, 2309];
	M(ci) = c(98);

	ci = [1475, 1522, 1569, 1616, 1663, 2357];
	M(ci) = c(99);

	ci = [1715, 1762, 1857, 2000, 2191, 2405];
	M(ci) = c(100);

	ci = [1763, 1810, 1905, 2048, 2239, 2453];
	M(ci) = c(101);

	ci = [1859, 1906, 1953, 2096, 2287, 2501];
	M(ci) = c(102);

	ci = [2003, 2050, 2097, 2144, 2335, 2549];
	M(ci) = c(103);

	ci = [2195, 2242, 2289, 2336, 2383, 2597];
	M(ci) = c(104);

	ci = [2435, 2482, 2529, 2576, 2623, 2645];
	M(ci) = c(105);

	ci = [40, 87, 230, 517, 996, 1686];
	M(ci) = c(106);

	ci = [88, 135, 278, 565, 1044, 1734];
	M(ci) = c(107);

	ci = [136, 183, 326, 613, 1092, 1782];
	M(ci) = c(108);

	ci = [232, 279, 374, 661, 1140, 1830];
	M(ci) = c(109);

	ci = [280, 327, 422, 709, 1188, 1878];
	M(ci) = c(110);

	ci = [376, 423, 470, 757, 1236, 1926];
	M(ci) = c(111);

	ci = [520, 567, 662, 805, 1284, 1974];
	M(ci) = c(112);

	ci = [568, 615, 710, 853, 1332, 2022];
	M(ci) = c(113);

	ci = [664, 711, 758, 901, 1380, 2070];
	M(ci) = c(114);

	ci = [808, 855, 902, 949, 1428, 2118];
	M(ci) = c(115);

	ci = [1000, 1047, 1142, 1285, 1476, 2166];
	M(ci) = c(116);

	ci = [1048, 1095, 1190, 1333, 1524, 2214];
	M(ci) = c(117);

	ci = [1144, 1191, 1238, 1381, 1572, 2262];
	M(ci) = c(118);

	ci = [1288, 1335, 1382, 1429, 1620, 2310];
	M(ci) = c(119);

	ci = [1480, 1527, 1574, 1621, 1668, 2358];
	M(ci) = c(120);

	ci = [1720, 1767, 1862, 2005, 2196, 2406];
	M(ci) = c(121);

	ci = [1768, 1815, 1910, 2053, 2244, 2454];
	M(ci) = c(122);

	ci = [1864, 1911, 1958, 2101, 2292, 2502];
	M(ci) = c(123);

	ci = [2008, 2055, 2102, 2149, 2340, 2550];
	M(ci) = c(124);

	ci = [2200, 2247, 2294, 2341, 2388, 2598];
	M(ci) = c(125);

	ci = [2440, 2487, 2534, 2581, 2628, 2646];
	M(ci) = c(126);

	ci = [45, 92, 235, 522, 1001, 1687];
	M(ci) = c(127);

	ci = [93, 140, 283, 570, 1049, 1735];
	M(ci) = c(128);

	ci = [141, 188, 331, 618, 1097, 1783];
	M(ci) = c(129);

	ci = [237, 284, 379, 666, 1145, 1831];
	M(ci) = c(130);

	ci = [285, 332, 427, 714, 1193, 1879];
	M(ci) = c(131);

	ci = [381, 428, 475, 762, 1241, 1927];
	M(ci) = c(132);

	ci = [525, 572, 667, 810, 1289, 1975];
	M(ci) = c(133);

	ci = [573, 620, 715, 858, 1337, 2023];
	M(ci) = c(134);

	ci = [669, 716, 763, 906, 1385, 2071];
	M(ci) = c(135);

	ci = [813, 860, 907, 954, 1433, 2119];
	M(ci) = c(136);

	ci = [1005, 1052, 1147, 1290, 1481, 2167];
	M(ci) = c(137);

	ci = [1053, 1100, 1195, 1338, 1529, 2215];
	M(ci) = c(138);

	ci = [1149, 1196, 1243, 1386, 1577, 2263];
	M(ci) = c(139);

	ci = [1293, 1340, 1387, 1434, 1625, 2311];
	M(ci) = c(140);

	ci = [1485, 1532, 1579, 1626, 1673, 2359];
	M(ci) = c(141);

	ci = [1725, 1772, 1867, 2010, 2201, 2407];
	M(ci) = c(142);

	ci = [1773, 1820, 1915, 2058, 2249, 2455];
	M(ci) = c(143);

	ci = [1869, 1916, 1963, 2106, 2297, 2503];
	M(ci) = c(144);

	ci = [2013, 2060, 2107, 2154, 2345, 2551];
	M(ci) = c(145);

	ci = [2205, 2252, 2299, 2346, 2393, 2599];
	M(ci) = c(146);

	ci = [2445, 2492, 2539, 2586, 2633, 2647];
	M(ci) = c(147);

	ci = [240, 527, 1006, 1688];
	M(ci) = c(148);

	ci = [288, 575, 1054, 1736];
	M(ci) = c(149);

	ci = [336, 623, 1102, 1784];
	M(ci) = c(150);

	ci = [384, 671, 1150, 1832];
	M(ci) = c(151);

	ci = [432, 719, 1198, 1880];
	M(ci) = c(152);

	ci = [480, 767, 1246, 1928];
	M(ci) = c(153);

	ci = [672, 815, 1294, 1976];
	M(ci) = c(154);

	ci = [720, 863, 1342, 2024];
	M(ci) = c(155);

	ci = [768, 911, 1390, 2072];
	M(ci) = c(156);

	ci = [912, 959, 1438, 2120];
	M(ci) = c(157);

	ci = [1152, 1295, 1486, 2168];
	M(ci) = c(158);

	ci = [1200, 1343, 1534, 2216];
	M(ci) = c(159);

	ci = [1248, 1391, 1582, 2264];
	M(ci) = c(160);

	ci = [1392, 1439, 1630, 2312];
	M(ci) = c(161);

	ci = [1584, 1631, 1678, 2360];
	M(ci) = c(162);

	ci = [1872, 2015, 2206, 2408];
	M(ci) = c(163);

	ci = [1920, 2063, 2254, 2456];
	M(ci) = c(164);

	ci = [1968, 2111, 2302, 2504];
	M(ci) = c(165);

	ci = [2112, 2159, 2350, 2552];
	M(ci) = c(166);

	ci = [2304, 2351, 2398, 2600];
	M(ci) = c(167);

	ci = [2544, 2591, 2638, 2648];
	M(ci) = c(168);

	M(1689) = c(169);
	M(1737) = c(170);
	M(1785) = c(171);
	M(1833) = c(172);
	M(1881) = c(173);
	M(1929) = c(174);
	M(1977) = c(175);
	M(2025) = c(176);
	M(2073) = c(177);
	M(2121) = c(178);
	M(2169) = c(179);
	M(2217) = c(180);
	M(2265) = c(181);
	M(2313) = c(182);
	M(2361) = c(183);
	M(2409) = c(184);
	M(2457) = c(185);
	M(2505) = c(186);
	M(2553) = c(187);
	M(2601) = c(188);
	M(2649) = c(189);
	M(1690) = c(190);
	M(1738) = c(191);
	M(1786) = c(192);
	M(1834) = c(193);
	M(1882) = c(194);
	M(1930) = c(195);
	M(1978) = c(196);
	M(2026) = c(197);
	M(2074) = c(198);
	M(2122) = c(199);
	M(2170) = c(200);
	M(2218) = c(201);
	M(2266) = c(202);
	M(2314) = c(203);
	M(2362) = c(204);
	M(2410) = c(205);
	M(2458) = c(206);
	M(2506) = c(207);
	M(2554) = c(208);
	M(2602) = c(209);
	M(2650) = c(210);

    Mr = M(:,1:48)\M(:,49:56);
    
	A = zeros(8);
    amcols = [8 7 6 5 4 3 2 1];
	A(1, 6) = 1;
	A(2, :) = -Mr(46, amcols);
	A(3, :) = -Mr(42, amcols);
	A(4, :) = -Mr(39, amcols);
	A(5, :) = -Mr(37, amcols);
	A(6, :) = -Mr(36, amcols);
	A(7, :) = -Mr(31, amcols);
	A(8, :) = -Mr(27, amcols);

	[V ~] = eig(A);
	sol =  V([6, 5, 4, 3, 2],:)./repmat(V(1,:),5,1);

	I = not(imag( sol(1,:) ))&not(isnan( sol(1,:) ));
	b1 = sol(1,I);
	b2 = sol(2,I);
	b3 = sol(3,I);
	b4 = sol(4,I);
	b5 = sol(5,I);
