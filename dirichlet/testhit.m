function res = testhit(hobject, hax)

mousePos = hobject.CurrentPoint;
mouseX   = mousePos(1);
mouseY   = mousePos(2);

uiControlPos = hax.Position; 
figurePos = hobject.Position; 

uiControlXL  = uiControlPos(1)*figurePos(3);
uiControlXU  = (uiControlPos(1)+uiControlPos(3))*figurePos(3);
uiControlYL  = uiControlPos(2)*figurePos(4);
uiControlYU  = (uiControlPos(2)+uiControlPos(4))*figurePos(4);

res =  mouseX>=uiControlXL && mouseX<=uiControlXU && ...
  mouseY>=uiControlYL && mouseY<=uiControlYU; 