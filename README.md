# pca_plot
A better plot for your PCA results

Example:
>> data = rand(30,20);
>> [coeff,~,~,~,explained] = pca(data);
>> h = pca_plot(coeff,explained,num2cell(1:20),[],'.');
