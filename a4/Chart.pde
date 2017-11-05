public abstract class Chart extends Viewport{

  protected String name;
  //protected Data data;

  public Chart(int chartX, int chartY, int chartWidth, int chartHeight){
    super(chartX, chartY, chartWidth, chartHeight);
    //this.data = data;
    //this.name = name;
  }

  public abstract void draw();

  public String getName(){
    return this.name;
  }

  //public Data getData(){
  //  return this.data;
  //}

}