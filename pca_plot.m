function h = pca_plot(coeff,explained,varlabels,subset,marker,fontsize)

%% plot pca() result, because I don't like biplot()
% Author: Jiun Yen
% Date: 01.01.2016
% Version: 06.12.2017
%
% Example:
%  [coeff,~,~,~,explained] = pca(data);
%  pca_plot(coeff)  or  pca_plot(coeff, explained)
%
% other input:
%  varlabels - cell array of labels for each point (N columns) of coeff
%  subset - integer array of indices of coeff columns to plot
%  marker - default 'o'
%  fontsize - default 10

Ncomp = size(coeff,2);
if Ncomp < 2
    error('Not enough components, need at least 2');
end
if nargin < 2 || isempty(explained)
    explained = [];
end
if nargin < 3 || isempty(varlabels)
    varlabels = [];
end
if nargin < 4 || isempty(subset)
    subset = 1:size(coeff,1);
end
if nargin < 5 || isempty(marker)
    marker = 'o';
end
if nargin < 6 || isempty(fontsize)
    fontsize = 10;
end

%% plot

h = figure;
hold on

maxX = max(abs(coeff(subset,1)));
plot([-maxX maxX],[0 0],'r--');
maxY = max(abs(coeff(subset,2)));
plot([0 0],[-maxY maxY],'r--');
xlim([-maxX*1.1 maxX*1.1])
ylim([-maxY*1.1 maxY*1.1])

dx = maxX/50;    % offset distance of labels from data points
dy = maxY/50;

if Ncomp > 2
    maxZ = max(abs(coeff(subset,3)));
    plot3([0 0],[0 0],[-maxZ maxZ],'r--');
    zlim([-maxZ*1.1 maxZ*1.1])
    dz = maxZ/50;
    
    scatter3(coeff(subset,1),coeff(subset,2),coeff(subset,3),marker)
    if ~isempty(varlabels)
        text(coeff(subset,1)+dx,coeff(subset,2)+dy,coeff(subset,3)+dz,varlabels(subset),'FontSize',fontsize)
    end
    
    view(3)
else
    scatter(coeff(subset,1),coeff(subset,2),marker);
    if ~isempty(varlabels)
        text(coeff(subset,1)+dx,coeff(subset,2)+dy,varlabels(subset),'FontSize',fontsize)
    end
end

if isempty(explained)
    xlabel('comp 1')
    ylabel('comp 2')
    if Ncomp > 2
        zlabel('comp 3')
    end
else
    xlabel(['comp 1 (' num2str(round(explained(1),1)) '%)'])
    ylabel(['comp 2 (' num2str(round(explained(2),1)) '%)'])
    if Ncomp > 2
        zlabel(['comp 3 (' num2str(round(explained(3),1)) '%)'])
    end
end
