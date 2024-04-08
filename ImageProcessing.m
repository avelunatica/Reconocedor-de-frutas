function [Characteristics] = ImageProcessing(OriginalImage)
%Function to do all the image processing
%We will binarize the images we preprocessed applying them contrast for
%better results
%   INPUT:
%       -   OriginalImage: The image we want to process
%   OUTPUT
%       -   Characteristics: The characteristic RGB vector


% COLOUR IMPROVEMENT

% Coloured Images to B&W images
R=OriginalImage(:,:,1); % R
G=OriginalImage(:,:,2); % G
B=OriginalImage(:,:,3); % B
BWImage = 0.3*R+0.59*G+0.11*B; %luminance

% Min and Max luminance
maxLuminance=max(max(BWImage)); %max from columns maxs
minLuminance=min(min(BWImage));
R = ((R - minLuminance) ./ (maxLuminance  - minLuminance));
G = ((G - minLuminance) ./ (maxLuminance  - minLuminance));
B = ((B - minLuminance) ./ (maxLuminance  - minLuminance));
ContrastImage = cat(3, R, G, B);

% BINARIZATION

HSV=rgb2hsv(ContrastImage);
S = HSV(:,:,2); %Saturation

% Calcutation of the threshold and binarization
Threshold = multithresh(S); %Single threshold value thresh computed for image A using Otsu’s method
BW=imbinarize(S,Threshold); %Creates a binary image from image I using a Threshold
Mask = imfill(BW,'holes');  %Fills holes in the input binary image BW

%Calculation of each RGB mean
BinarizeImage=cat(3,ContrastImage(:,:,1).*Mask,ContrastImage(:,:,2).*Mask,ContrastImage(:,:,3).*Mask);
        %R
R=BinarizeImage(:,:,1); 
MeanR = mean(nonzeros(R));
        %G
G=BinarizeImage(:,:,2); 
MeanG = mean(nonzeros(G));
        %B
B=BinarizeImage(:,:,3); 
MeanB = mean(nonzeros(B));

Characteristics=[MeanR MeanG MeanB];
end

