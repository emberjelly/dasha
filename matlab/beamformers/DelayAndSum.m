classdef DelayAndSum
    %DELAYANDSUM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        fs = 16000;
        d = 1;
        fc = 2000;
        c = 340;
        angle = 0;
        block_size = 1024;
        num_elements;
        states = [];
        window = [];
        delays = [];
        filters = [];
    end
    
    methods
        function obj = DelayAndSum(d, fc, num_elements, fs, angle, c, block_size, window)
            if nargin >= 5
                obj.d = d;
                obj.fc = fc;
                obj.num_elements = num_elements;
                obj.fs = fs;
                obj.angle = angle;
            end 

            if nargin >= 6
                obj.c = c;
            end
            
            if nargin >= 7
                obj.block_size = block_size;
            end
            
            if nargin >= 8
                obj.window = window;
            else
                obj.window = ones(1, obj.num_elements);
            end
            
            obj.delays = obj.fs*(-round(obj.num_elements/2):round(obj.num_elements/2) - 1)*obj.d*sin(angle*pi/180)/obj.c;
            obj.filters = zeros(obj.num_elements, 41);
            for i = 1:num_elements
                obj.filters(i, :) = sinc((-20:20) + obj.delays(i));
            end
        end
        
        function [output] = process(obj, input)
            
            output = zeros(length(input), 1);
            
            count = 1;
            for ch = input
                %output = output + obj.window(count)*filter(obj.filters(count, :), 1, ch);
                output = output + filter(obj.filters(count, :), 1, ch);
                
                count = count + 1;
            end
            
        end
    end
end

