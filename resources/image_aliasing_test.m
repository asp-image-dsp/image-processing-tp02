clear all;
close all;

f = imread('barbara.gif');
[ysize,xsize] = size(f);


xshrink = 300

desiredxsize = xsize - xshrink;
scale_shrink = desiredxsize / xsize;
T = maketform('affine',[scale_shrink 0 0; 0 scale_shrink 0; 0 0 1]);
f2 = imtransform(f,T);
[currentysize, currentxsize] = size(f2);

scale_boost = xsize / currentxsize;
Tinv = maketform('affine',[scale_boost 0 0; 0 scale_boost 0; 0 0 1]);

f3 = imtransform(f2,Tinv,'size',[ysize xsize]);
Fd = fftshift(log(1+abs(fft2(f3))));
Fi = fftshift(log(1+abs(fft2(f))));
% imshow([f3/max(max(f3));Fd/max(max(Fd))]);
% imshow(f3);
fr = im2frame(f3, gray(256));
Fdr = im2frame(uint8(256*Fd/max(max(Fd))), gray(256));

figure
imshow(uint8(256*Fi/max(max(Fi))));
figure
imshow(uint8(256*Fd/max(max(Fd))));