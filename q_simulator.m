%quantum simulator
function [final_state,prob,qckt_matrix] = q_simulator()
    qckt = input('input qckt:');
    qbit = size(qckt,1);
    function operator = gate(name) 
        switch name
          case 'I'
              operator = [1,0;0,1];
          case 'X'
              operator = [0,1;1,0];
          case 'Z'
              operator = [1,0;0,-1];
          case 'H'
              operator =(1/2^(1/2))*[1,1;1,-1];
          otherwise
              error 'wrong gate'
       end
    end
    initial_state = zeros(2^qbit,1);
    initial_state(1,1) = 1;
    v = size(qckt,2);
    qckt_matrix = eye(2^qbit);
    op = " ";
    final_state = initial_state;
    for m = 1:v
        s = eye(1);
        n = 1;
       while n <= qbit
          op = split(qckt(n,m));
          s = kron(s,gate(op)); 
          n = n+1;
      end
      qckt_matrix = qckt_matrix*s
   end
   final_state = qckt_matrix*final_state
   prob = abs(final_state).^2
   bar(0:2^qbit-1,prob*100)
   xlabel('qstates in decimal no.');
   ylabel('probability %');
 end
