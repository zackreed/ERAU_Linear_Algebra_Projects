function plot_star_wars(matrix)
    figure(3);
    plot3(matrix(:,1),matrix(:,2),matrix(:,3),'r.','MarkerSize',30);
    xlabel('Episode IV Rating');
    ylabel('Episode V Rating');
    zlabel('Episode VI Rating');
    title("Users' Ratings of Star Wars")
    
end