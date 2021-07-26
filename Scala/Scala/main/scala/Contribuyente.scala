case class Contribuyente(
                    age: Int,
                    workclass: String,
                    education: String,
                    educationNum: Int,
                    maritalStatus: String,
                    occupation: String,
                    relationship: String,
                    race: String,
                    sex: String,
                    capitalGain: Int,
                    capitalLoss: Int,
                    hoursPerWeek: Int,
                    nativeCountry: String,
                    income: String
                  )

// Implementa el companion object
// ejercicio-8:
// Dada la clase 'Contribuyente' y es a la que se mapea cada fila del csv, se pide que se cree su companion object y
// defina la función:
//  - imprimeDatos que muestre por consola el siguiente formato: "$workclass - $occupation - $nativeCountry - $income"
//  - apply, que no reciba ningún parámetro y que devolverá una instancia de la clase Contribuyente con aquellos campos que sean:
//     del tipo Int inicializados a -1
//     del tipo String inicializado a “desconocido

object Contribuyente{
  def imprimeDatos(c:Seq[Contribuyente]): Unit ={
    c.foreach (x => println (s"${x.workclass} - ${x.occupation} - ${x.nativeCountry} - ${x.income}"))
  }

}