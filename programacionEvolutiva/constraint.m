function [c, ceq] = constraint(x)
    c = [];           % restrictions of inequality
    ceq = sum(x) - 1; % restrictions of equality
end
