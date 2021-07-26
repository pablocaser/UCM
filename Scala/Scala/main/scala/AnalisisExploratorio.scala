
object AnalisisExploratorio extends App {

  val dataset = Utilidades.readFile(fichero = "src/adult.data.clean.csv")
  dataset
  // Implementa la función
  // ejercicio-1:
  // Número total de registros en el dataset.

  def totalDeRegistros(c: Seq[Contribuyente]): Int = {
    c.length
  }
    // Implementa la función
    // ejercicio-2:
    // Calcular la media de edad de todos los contribuyentes

  def calculaEdadMedia(c: Seq[Contribuyente]): Double = {
    val edad = c.map( Contribuyente => Contribuyente.age)
    edad.sum.toDouble / edad.length
  }

  // Implementa la función
  // ejercicio-3:
  // Calcular la media de edad de todos los contribuyentes sin contar aquellos cuya edad sea 0
  def calculaEdadMediaNoZeros(c: Seq[Contribuyente]): Double = {
    val edadNoCeros = c.filter(m => m.age>0).map(_.age)
    edadNoCeros.sum.toDouble/edadNoCeros.length
  }

  // Implementa la función
  // ejercicio-4:
  // Descubrir de cuántos países distintos provienen los contribuyentes
  def paisesOrigenUnicos(c: Seq[Contribuyente]): Seq[String] = {
    val paisesUnic = c.map(n => n.nativeCountry).distinct
    paisesUnic
  }

  // Implementa la función
  // ejercicio-5:
  // De todos los contribuyentes, ¿cómo se distribuye por género?. Devuelve el porcentaje de hombres
  // y el de mujeres en ese orde, (porcentajeDeHombres, porcentajeDeMujeres)
  def distribucionPorGeneros(c: Seq[Contribuyente]): (Double, Double) = {
    val hombres = c.filter(x => x.sex == "Male").map(_.sex)
    val mujeres = c.filter(x => x.sex == "Female").map(_.sex)
    val PorcentajeH = hombres.length/(hombres.length+mujeres.length).toDouble
    val PorcentajeM = mujeres.length/(hombres.length+mujeres.length).toDouble
    (PorcentajeH,PorcentajeM)
  }

  // Implementa la función
  // ejercicio-6:
  // Cuál es el tipo de trabajo (workclass) cuyos ingresos son mayoritariamente superiores a ">50K
  def trabajoMejorRemunerado(c: Seq[Contribuyente]): String= {
    val worklcass50K = c.filter(x => x.income == ">50K").map(_.workclass)
    val workclassGroup = worklcass50K.groupBy(l => l).map(t => (t._1, t._2.length))
    workclassGroup.maxBy(_._2)._1
  }

  // Implementa la función
  // ejercicio-7:
  // Cuál es la media de años de educación (education-num) de aquellos contribuyentes cuyo país de origen no es
  // United-States
  def aniosEstudiosMedio(c: Seq[Contribuyente]): Double = {
    val edadEdu = c.filter(x => x.nativeCountry != "United-States").map(_.educationNum)
    edadEdu.sum.toDouble/edadEdu.length
  }


//println(s" -> Dataset tiene un total de registros: ${totalDeRegistros(c = dataset)}")
//println(s" -> En el dataset, los contribuyentes tienen una edad media: ${calculaEdadMedia(c = dataset)}")
 //println(s" -> En el dataset, los contribuyentes tienen una edad media (sin contar aquellos con age = 0): ${calculaEdadMediaNoZeros(c = dataset)}")
   //println(s" -> Los contribuyentes proviende de distintos países como: ${paisesOrigenUnicos(c = dataset).foreach(println)}")
 //println(s" -> Los contribuyentes se distribuyen en (hombres - mujeres): ${distribucionPorGeneros(c = dataset)}")
//println(s" -> El tipo de trabajo mejor remunerado en el dataset es: ${trabajoMejorRemunerado(c = dataset)}")
  //  println(s" -> La media de años de estudio de los contribuyenes de origen distinto a United States es: ${aniosEstudiosMedio(c = dataset)}")

  // ejercicio-11
  // llama a la función impimeContribuyentes
  class Imprime extends Analizador {
    imprimeContribuyentes(c = dataset)
  }
var obj = new Imprime()
obj.imprimeContribuyentes(c = dataset)
}
