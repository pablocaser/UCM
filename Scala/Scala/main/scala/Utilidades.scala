import scala.io.Source.fromFile

object Utilidades {
  def readFile(fichero: String): Seq[Contribuyente] = {

    def getDefaultInt(v: String, d: Int) = if (v.isEmpty()) d else v.toInt

    var i: Int = 0
    var rows: Seq[Contribuyente] = Seq.empty
    for (l <- fromFile(fichero).getLines()){
      if (i > 0) {
        val Array(age, workclass, education, educationNum, maritalStatus, occupation, relationship, race, sex, capitalGain, capitalLoss, hoursPerWeek, nativeCountry, income) =  l.split(",")
        rows = rows ++ Seq(Contribuyente(
          age = getDefaultInt(age, 0),
          workclass = workclass.replace("\"", ""),
          education = education.replace("\"", ""),
          educationNum = getDefaultInt(educationNum, 0),
          maritalStatus = maritalStatus.replace("\"", ""),
          occupation = occupation.replace("\"", ""),
          relationship = relationship.replace("\"", ""),
          race = race.replace("\"", ""),
          sex = sex.replace("\"", ""),
          capitalGain = getDefaultInt(capitalGain, 0),
          capitalLoss = getDefaultInt(capitalLoss, 0),
          hoursPerWeek = getDefaultInt(hoursPerWeek, 0),
          nativeCountry = nativeCountry.replace("\"", ""),
          income = income.replace("\"", ""),
        ))
      }
      else {
        i += 1
      }
    }
    rows
  }
}
