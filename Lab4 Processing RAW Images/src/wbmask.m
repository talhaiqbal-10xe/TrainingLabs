function colormask = wbmask(m,n,wbmults,align)

% %Makes a white-balance multiplicative mask for an image of size m-by-n
% with RGB while balance multipliers WBMULTS = [R_scale G_scale B_scale].
% ALIGN is string indicating Bayer arrangement: ’rggb’,’gbrg’,’grbg’,’bggr’

%     0 1 2 3 4 5	  0 1 2 3 4 5	  0 1 2 3 4 5	  0 1 2 3 4 5
% 	0 B G B G B G	0 G R G R G R	0 G B G B G B	0 R G R G R G
% 	1 G R G R G R	1 B G B G B G	1 R G R G R G	1 G B G B G B
% 	2 B G B G B G	2 G R G R G R	2 G B G B G B	2 R G R G R G
% 	3 G R G R G R	3 B G B G B G	3 R G R G R G	3 G B G B G B


colormask = wbmults(2)*ones(m,n); %Initialize to all green values
switch align
case 'rggb'
colormask(1:2:end,1:2:end) = wbmults(1); %r
colormask(2:2:end,2:2:end) = wbmults(3); %b
case 'bggr'
colormask(2:2:end,2:2:end) = wbmults(1); %r
colormask(1:2:end,1:2:end) = wbmults(3); %b
case 'grbg'
colormask(1:2:end,2:2:end) = wbmults(1); %r
colormask(1:2:end,2:2:end) = wbmults(3); %b
case 'gbrg'
colormask(2:2:end,1:2:end) = wbmults(1); %r
colormask(1:2:end,2:2:end) = wbmults(3); %b
end
end