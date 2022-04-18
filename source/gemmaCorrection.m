function out=gemmaCorrection(inp,gemma)
out = inp/255;
out = out.^1/gemma;
out = out*255;