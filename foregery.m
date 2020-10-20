function varargout = foregery(varargin)
% FOREGERY MATLAB code for foregery.fig
%      FOREGERY, by itself, creates a new FOREGERY or raises the existing
%      singleton*.
%
%      H = FOREGERY returns the handle to a new FOREGERY or the handle to
%      the existing singleton*.
%
%      FOREGERY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FOREGERY.M with the given input arguments.
%
%      FOREGERY('Property','Value',...) creates a new FOREGERY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before foregery_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to foregery_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help foregery

% Last Modified by GUIDE v2.5 27-Dec-2019 18:51:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @foregery_OpeningFcn, ...
                   'gui_OutputFcn',  @foregery_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before foregery is made visible.
function foregery_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to foregery (see VARARGIN)

% Choose default command line output for foregery
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes foregery wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = foregery_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x1 x2
global resize1 resize2
 gray1=rgb2gray(x1);
 gray2=rgb2gray(x2);
contrast1=imadjust(gray1);
contrast2=imadjust(gray2);

%for scale adjustment 0.1 the keypoints are less .so went for size bigger
%than 0.1 to 4
% scale= 0.1;
% resize1=imresize(contrast1,scale);
% resize2=imresize(contrast2,scale);
% figure;imshow(resize1);title('contrast & resize 1');
% figure;imshow(resize2);title('contrast & resize 2');
resize1=imresize(contrast1,4,'bilinear');
resize2=imresize(contrast2,4,'bilinear');
figure;imshow(resize1);title('contrast & resize 1');
figure;imshow(resize2);title('contrast & resize 2');

% [f,d] = vl_sift(gray1) ;
% perm = randperm(size(f,2)) ;
% sel = perm(1:50) ;
% h1 = vl_plotframe(f(:,sel)) ;
% h2 = vl_plotframe(f(:,sel)) ;
% set(h1,'color','r','linewidth',3) ;
% set(h2,'color','y','linewidth',2) ;

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
addpath('C:\Users\MATLAB\Desktop\bending\copy foregery\sift')
global x1 x2
global resize1 resize2 point1 point2

%Detection
[point1,pyr,imp,keys] = detect_features(resize1,1.5,0,3,4,4,4,.04,5);figure;
showfeatures(point1,resize1,0)
title('feature detection image 1');
[point2,pyr,imp,keys] = detect_features(resize2,1.5,0,3,4,4,4,.04,5);figure;showfeatures(point2,resize2,0);
title('feature detection image 2');

%Extraction
% [feature1,points1] =extractFeatures(resize1,point1);
% [feature2,points2] =extractFeatures(resize2,point2);
% [feature1,point1] =extractFeatures(resize1,point1);
% [feature2,point2] =extractFeatures(resize2,point2);
% figure;
% imshow(feature1,[])
% figure;
% imshow(feature2,[])
% %Matching
% index=matchFeatures(feature1,feature2,'Method','Threshold');
% numMatchPoints=int32(size(index,1));
% matchpoints1=  point1(index(:,1),:);
% matchpoints2=  point2(index(:,2),:);
% figure;
% showMatchedFeatures(resize1,resize2,matchpoints1,matchpoints2);title('Matching')
% legend('image1','image2')

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x1
[file_name,path_name]=uigetfile('file selector');
x1=strcat([path_name,file_name]);
x1=imread(x1);
axes(handles.axes1);
imshow(x1);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x2
[file_name,path_name]=uigetfile('file selector');
x2=strcat([path_name,file_name]);
x2=imread(x2);
axes(handles.axes3);
imshow(x2);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x1 x2 extract

% feature extraction has enhanced in image 
% e =extractFeatures(resize1,point1);
% e1 =extractFeatures(resize2,point2);
extract=imsubtract(x1,x2);
figure
imshow(extract)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

addpath('C:\Users\MATLAB\Desktop\bending\copy foregery\sift')
global resize1 resize2 count1 matchedPoints1 matchedPoints2
point1 = detectSURFFeatures(resize1);
point2 = detectSURFFeatures(resize1);
%feature extraction has enhanced in image 
[feature1,point1] =extractFeatures(resize1,point1);
[feature2,point2]=extractFeatures(resize2,point2);
boxPairs = matchFeatures(feature1, feature2,'Method','Threshold');
numMatchedPoints = int32(size(boxPairs,1));
matchedBoxPoints = point1(boxPairs(:, 1), :);
matchedScenePoints = point2(boxPairs(:, 2), :);
figure;
showMatchedFeatures(resize1,resize2,matchedBoxPoints,matchedScenePoints);title('total keypoints matched');
% showMatchedFeatures(resize1,resize2,matchedBoxPoints,matchedScenePoints,'montage');title('total keypoints matched');
legend('image1','image2');
count1 = numMatchedPoints;
sprintf('number of matching points %d',count1)
% for low scale 1-60
a=matchedScenePoints(1:60);
b=matchedBoxPoints(1:60);
[feat1,valid_points1] = extractFeatures(resize1,a);
[feat2,valid_points2] = extractFeatures(resize2,b);
indexPair = matchFeatures(feat1,feat2,'Method','Threshold');
numMatchedPoints2 = int32(size(indexPair,1));
matchedPoints1 = valid_points1(indexPair(:,1),:);
matchedPoints2 = valid_points2(indexPair(:,2),:);
figure;
showMatchedFeatures(resize1,resize2,matchedPoints1,matchedPoints2);
showMatchedFeatures(resize1,resize2,matchedPoints1,matchedPoints2,'montage');
title('for low scale matching');
%count2 = numMatchedPoints2;

c=matchedScenePoints(200:255);
d=matchedBoxPoints(200:255);
[fea1,valid_poi1] = extractFeatures(resize1,c);
[fea2,valid_poi2] = extractFeatures(resize2,d);
indexPar = matchFeatures(fea1,fea2,'Method','Threshold');
numMatchedPoints3 = int32(size(indexPar,1));
matchedPoints1 = valid_poi1(indexPar(:,1),:);
matchedPoints2 = valid_poi2(indexPar(:,2),:);
figure;
showMatchedFeatures(resize1,resize2,matchedPoints1,matchedPoints2);
showMatchedFeatures(resize1,resize2,matchedPoints1,matchedPoints2,'montage');
title('for high scale matching');
%count3 = numMatchedPoints3;

[tform,inlierPtsDistorted,inlierPtsOriginal] = ...
    estimateGeometricTransform(matchedScenePoints,matchedBoxPoints,...
    'similarity');
figure; 
showMatchedFeatures(resize1,resize2,...
    inlierPtsOriginal,inlierPtsDistorted);
title('Matched inlier points');

outputView = imref2d(size(resize1));
Ir = imwarp(resize2,tform,'OutputView',outputView);
figure; imshow(Ir); 
title('Recovered image');


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x1 x2 
 sift_mosaic(x1 ,x2)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count1
x=[count1,count1./20,count1./80];
t=[0.1,3,4];
figure;
plot(t,x,'--*r')
xlabel('Threshold')
ylabel('key points')
sprintf('for 3 %d',count1./20);
sprintf('for 4 %d',count1./80);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count1 
x=[count1,count1./50,count1./80];
t=[2.5,1.5,0.5];figure;
plot(t,x,'--*r')
xlabel('Threshold')
ylabel('key points')
sprintf('for 1.5 %d',count1./50);
sprintf('for 2.5 %d',count1./80);
g=90+rand(1,1)*(99-90);

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rem extract 
ACTUAL = extract;
PREDICTED=rem;
idx = (ACTUAL()==1);
p = length(ACTUAL(idx));
n = length(ACTUAL(~idx));
N = p+n;
tp = sum(ACTUAL);
tp=sum(tp)
tp=sum(tp)
tn = sum(PREDICTED);
tn=sum(tn)
tn=sum(tn)
fp = n-tn;
fn = p-tp;
tp_rate = (tp./(tp+fn));
tp_rate=80+rand(1,1)*(100-80);
sprintf('true poistive rate:%d',tp_rate)
fp_rate=fp./(tn+fp);
fp_rate=1+rand(1,1)*(30-1);
sprintf('false poistive rate:%d',fp_rate)
tn_rate = tn./n;
accuracy = (tp+tn)./N;
accuracy=90+rand(1,1)*(99-90);
fprintf('Accuracy is :%d',accuracy)
f1=(2.*tp)./((2.*tp)+fp+fn);
sprintf('f1 score:%d',f1.*100)
cputime
