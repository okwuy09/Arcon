import 'package:arcon/app.dart';
import 'package:arcon/config/config.dart';
import 'package:arcon/controllers/controllers.dart';
import 'package:arcon/pages/calendar/calendar.dart';
import 'package:arcon/pages/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Calendar extends StatelessWidget {
  const Calendar ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      color: CustomColors.grey[2],
      child: LayoutBuilder(
          builder: (context, constraints) {

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                height: App.screenHeight,
                child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        children: [

                          SizedBox(
                            height: App.screenHeight * 0.05,
                          ),

                          SingleChildScrollView(
                            controller: ScrollController(),
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: App.screenHeight * 0.05
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _dayButton(
                                      text: "PRE CONFERENCE DAY ONE",
                                      index: 0
                                  ),

                                  _dayButton(
                                      text: "PRE CONFERENCE DAY TWO",
                                      index: 1
                                  ),

                                  _dayButton(
                                      text: "CONFERENCE DAY ONE",
                                      index: 2
                                  ),

                                  _dayButton(
                                      text: "CONFERENCE DAY TWO",
                                      index: 3
                                  ),

                                  _dayButton(
                                      text: "CONFERENCE DAY THREE",
                                      index: 4
                                  ),

                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: App.screenHeight * 0.025,
                          ),

                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: App.screenHeight * 0.05
                              ),
                              child: GetX<UserController>(
                                builder: (controller) {
                                  return IndexedStack(
                                    index: controller.scheduleIndex.value,
                                    children: [
                                      _preDayOne(),
                                      _preDayTwo(),
                                      _dayOne(),
                                      _dayTwo(),
                                      _dayThree(),
                                    ],
                                  );
                                }
                              ),
                            ),
                          ),

                          SizedBox(
                            height: App.screenHeight * 0.025,
                          ),
                        ],
                      );
                    }
                ),
              ),
            );
          }
      ),
    );
  }

  Widget _dayButton({required String text, required int index}) {
    return GetX<UserController>(
        builder: (controller) {
          return CustomButton(
            width: App.screenHeight * 0.3,
            text: text,
            borderColor: CustomColors.primary,
            color: controller.scheduleIndex.value == index ? CustomColors.primary
                : Colors.white,
            textColor: controller.scheduleIndex.value == index ? Colors.white
                : CustomColors.primary,
            onPressed: () {
              controller.scheduleIndex.value = index;
            },
            margin: EdgeInsets.symmetric(
                horizontal: App.screenHeight * 0.015
            ),
          );
        }
    );
  }

  Widget _preDayOne() {
    return const CalendarItem(
      elements: [
        CalendarElement(
          type: CalendarElementType.lectureHeader,
        ),

        CalendarElement(
          type: CalendarElementType.timedEvent,
          content: [
            "13:00 - 15:00",
            "Arrival and Lunch"
          ],
        ),

        CalendarElement(
          content: [
            "15:00 - 15:20",
            "Dr Uwagba",
            "Epidemiology of H&N Malignancies in Nigeria",
          ],
        ),

        CalendarElement(
          content: [
            "15:20 - 16:00",
            "Dr Onuh",
            "Radiological Anatomy of the Head and Neck",
          ],
        ),

        CalendarElement(
          content: [
            "16:00 - 16:20",
            "Prof Ezeanolue",
            "Overview of the role of surgery in the management of Head and Neck Malignancies",
          ],
        ),

        CalendarElement(
          content: [
            "16:20 - 16:30",
            "Dr Uwagba",
            "Case presentation from NLCC-Cancer Center",
          ],
        ),

        CalendarElement(
          content: [
            "16:35 - 17:00",
            "Dr Mary Ann",
            "Dadzie	RTOG Considerations for Laryngeal malignancy contouring and Treatment Planning",
          ],
        ),

        CalendarElement(
          type: CalendarElementType.timedEvent,
          content: [
            "17:00 - 18:30",
            "PRACTICAL DEMONSTRATION I - BREAKOUT SESSION AND HANDS ON WITH INSTRUCTORS - DR UWAGBA/DR DAO",
          ],
        ),

        CalendarElement(
          type: CalendarElementType.event,
          content: [
            "DINNER / CLOSE",
          ],
        ),
      ]
    );
  }

  Widget _preDayTwo() {
    return const CalendarItem(
        elements: [
          CalendarElement(
            type: CalendarElementType.lectureHeader,
          ),

          CalendarElement(
            type: CalendarElementType.lecture,
            content: [
              "08:15 -08:30",
              "LOC",
              "Welcome and Recap",
            ],
          ),

          CalendarElement(
            content: [
              "08:30 - 09:00",
              "Yasser Rather",
              "Treatment Planning Techniques for H&N Malignancies",
            ],
          ),

          CalendarElement(
            type: CalendarElementType.timedEvent,
            content: [
              "09:00 - 10:20",
              "PRACTICAL DEMONSTRATION II - BREAKOUT SESSION AND HANDS ON WITH INSTRUCTORS - DR UWAGBA/DR MARY ANN DADZIE",
            ],
          ),

          CalendarElement(
            type: CalendarElementType.timedEvent,
            content: [
              "10:20 - 10:40",
              "TEA BREAK",
            ],
          ),

          CalendarElement(
            content: [
              "10:40 - 11:10",
              "TBN",
              "Locally Advanced SCCHN: Cisplatine Eligibility: How patient profile dictates treatment choices in LA SCCHN\n	CHEMORADIATION",
            ],
          ),

          CalendarElement(
            content: [
              "11:10 - 11.40",
              "TBN",
              "The importance of individualized treatment in R/M SCCHN",
            ],
          ),

          CalendarElement(
            type: CalendarElementType.timedEvent,
            content: [
              "11:40 - 11:50",
              "Case Presentation from Asi Ukpo Cancer Center",
            ],
          ),

          CalendarElement(
            content: [
              "11:50 - 12:00",
              "Dr Dao",
              "",
            ],
          ),

          CalendarElement(
            content: [
              "12:00 - 12:30",
              "Dr Mary Ann Dadzie",
              "Practical Contouring Guidelines for NPC",
            ],
          ),

          CalendarElement(
            type: CalendarElementType.timedEvent,
            content: [
              "12:30 - 14:00",
              "PRACTICAL DEMONSTRATION III - BREAKOUT SESSION AND HANDS ON WITH INSTRUCTORS - DR UWAGBA/DR KAUSIK BHATTACHARYA",
            ],
          ),

          CalendarElement(
            type: CalendarElementType.timedEvent,
            content: [
              "14:00 - 14:30",
              "LUNCH BREAK",
            ],
          ),

          CalendarElement(
            content: [
              "14:30 -15:30",
              "Yasser Rather",
              "Patient Set up in H&N Malignancy - From Simulation to Treatment",
            ],
          ),

          CalendarElement(
            content: [
              "15:30 - 16:10",
              "Dr Court - MD Anderson",
              "Role of technology in H/N Treatment planning",
            ],
          ),

          CalendarElement(
            type: CalendarElementType.timedEvent,
            content: [
              "16:10 - 17:10",
              "PRACTICAL DEMONSTRATION IV - BREAKOUT SESSION AND HANDS ON WITH INSTRUCTORS - DR UWAGBA/DR KAUSIK BHATTACHARYA",
            ],
          ),

          CalendarElement(
            type: CalendarElementType.lecture,
            content: [
              "17:10 - 17:30",
              "LOC",
              "CLOSE/GROUP PHOTOGRAPH",
            ],
          ),
        ]
    );
  }

  Widget _dayOne() {
    return const CalendarItem(
        elements: [
          CalendarElement(
            type: CalendarElementType.lectureHeader2,
          ),

          CalendarElement(
            content: [
              "08:00 - 08:45",
              "Dr Sarimiye/Dr Maurice Nandul",
              "YOUNG ONCOLOGY FORUM",
              "Dr Oladeji/Dr Okwor\nDr Salako\nDr Omikunle",
            ],
          ),

          CalendarElement(
            content: [
              "08:45- 09:40",
              "Dr Igbinoba/Dr Ali-Gombe",
              "Abstract Presentation",
              "MULTI-MORBIDITY IN CANCER PATIENTS IN PORT HARCOURT\n"
                "ASSOCIATION OF SERUM LIPID PROFILE WITH PROSTATE CANCER RISK AND AGGRESSIVENESS IN NIGERIAN MEN\n"
                "A COMPARATIVE STUDY OF THE DOSIMETRIC OUTCOMES OF THE USE OF BOLUS "
                  "AND NON-BOLUS ON LEFT BREAST POST MASTECTOMY RADIOTHERAPY (LB-PMRT): "
                  "MARCELLE RUTH CANCER CENTRE AND SPECIALIST HOSPITAL (MRCCSH) EXPERIENCE\n"
                "HEAD AND NECK MALIGNANCY: THE MARCELLE RUTH CANCER CENTRE AND SPECIALIST HOSPITAL (MRCCSH) EXPERIENCE\n"
                "PROMOTING EQUITY IN RADIOTHERAPY ACCESS\n"
                "Model of Hospice Care Delivery for patients with advanced cancer in a  Resource limited setting",
            ],
          ),

          CalendarElement(
            content: [
              "09:40- 10:30",
              "Dr Ibraheem/Dr Vandepuye",
              "Best of ASCO",
              "Eli Lilly Pharmaceuticals",
            ],
          ),

          CalendarElement(
            type: CalendarElementType.timedEvent,
            content: [
              "10:30 - 10:50",
              "TEA BREAK",
            ],
          ),

          CalendarElement(
            content: [
              "10:50 - 11:10",
              "Dr Olatunji",
              "Low dose Rate Brachytherapy as a treatment option for localised prostate cancer",
              "Prof Frank Chinegwundu",
            ],
          ),

          CalendarElement(
            type: CalendarElementType.timedEvent,
            content: [
              "11:10 - 13:10",
              "OPENING CEREMONY",
              "Mr Lorenzo/Dr Ololade/Dr Kwis",
            ],
          ),

          CalendarElement(
            content: [
              "",
              "",
              "Welcome address",
              "LOC Chairman	- Dr Nwankwo",
            ],
          ),

          CalendarElement(
            content: [
              "",
              "",
              "Welcome address",
              "National President	- Dr Lasebikan",
            ],
          ),

          CalendarElement(
            content: [
              "",
              "",
              "Address",
              "CMD UNTH	- Prof Onodugo",
            ],
          ),

          CalendarElement(
            content: [
              "",
              "",
              "Address",
              "DG NICRAT - Prof Aliyu",
            ],
          ),

          CalendarElement(
            content: [
              "",
              "",
              "Address",
              "IAEA	- Dr Mickel Edwerd",
            ],
          ),

          CalendarElement(
            content: [
              "",
              "",
              "Introduction of Keynote Speaker\n"
                  "Keynote Speaker- The Ethics of Equity: Ethical imperatives in "
                  "Oncology-Balancing the interests of Patients, Practice and Policy makers",
              "Prof Ezeome",
            ],
          ),

          CalendarElement(
            content: [
              "",
              "",
              "Goodwill messages",
              "",
            ],
          ),

          CalendarElement(
            content: [
              "",
              "",
              "Award of Micro Grants",
              "",
            ],
          ),

          CalendarElement(
            content: [
              "",
              "",
              "Closing remarks",
              "HE",
            ],
          ),

          CalendarElement(
            content: [
              "",
              "",
              "Vote of thanks",
              "Dr Oladeji",
            ],
          ),

          CalendarElement(
            type: CalendarElementType.timedEvent,
            content: [
              "13:10 - 13:25",
              "TOUR OF BOOTHS",
            ],
          ),

          CalendarElement(
            type: CalendarElementType.timedEvent,
            content: [
              "13:10 - 14:00",
              "LUNCH",
            ],
          ),

          CalendarElement(
            content: [
              "14:00 - 15:00",
              "Dr Ikhile",
              "Cost of illness study\n"
                  "Access to Healthcare Financing: Universal healthcare coverage for all "
                  "cancer patients(Panel discussion: Dr Olumide, HE- Dr Bagudu, Prof Aliyu, Prof Sambo, Mr Ukachukwu)",
              "Roche",
            ],
          ),

          CalendarElement(
            content: [
              "15:00 - 15:30",
              "Dr Jimeta",
              "Halcyon - A new standard of care in Radiation Therapy",
              "Tim Clark/TANIT/VARIAN  Presentation",
            ],
          ),

          CalendarElement(
            content: [
              "15:30 - 16:30",
              "Dr Oboh - Data and Equity in Cancer care",
              "Data is King- Setting up a Research Database\n"
                  "Data and Equity - The role of the private sector\n"
                  "Diagnostics",
              "Dr Subhir Grover\nDr Mrs Modupe Elebute\nISN",
            ],
          ),

          CalendarElement(
            content: [
              "16:30 - 16:50",
              "",
              "Industry Presentation",
              "JNCI",
            ],
          ),

          CalendarElement(
            content: [
              "16:50 - 17:00",
              "",
              "Medilink",
              "",
            ],
          ),

          CalendarElement(
            content: [
              "17:00 - 17:10",
              "",
              "Industry Presentation",
              "Innoteck",
            ],
          ),

          CalendarElement(
            content: [
              "17:10 - 17:20",
              "",
              "Wrap up and closing remarks for Day 1",
              "LOC",
            ],
          ),

          CalendarElement(
            type: CalendarElementType.timedEvent,
            content: [
              "17:45 - 20:30",
              "GALA NIGHT",
            ],
          ),
        ]
    );
  }

  Widget _dayTwo() {
    return const CalendarItem(
      elements: [
        CalendarElement(
          type: CalendarElementType.lectureHeader2,
        ),

        CalendarElement(
          content: [
            "07:45 - 08:00",
            "Dr Shehu Umar",
            "Recap of Day 1",
            "",
          ],
        ),

        CalendarElement(
          content: [
            "08:00 - 08:50",
            "Dr Oyesegun/Dr Hannah Ayette",
            "YOUNG ONCOLOGY FORUM",
            "Dr Ntekkim/Dr Adamu\n"
                "Dr Aliyu\n"
                "Dr Vanderpuye/Dr Lasebikan",
          ],
        ),

        CalendarElement(
          content: [
            "08:50 - 09:30",
            "",
            "Role of partnership and collaboration in promoting equity in practice and research\n"
                "CRMP - Promoting research in RO",
            "Prof Isaac Alatise\n"
                "Prof Rebecca Wong",
          ],
        ),

        CalendarElement(
          content: [
            "09:30 - 10:40",
            "Dr Jimoh",
            "Ovarian Function Suppresion/Preservation in HR+ Premenopausal Breast Cancer Patients\n"
                "Fertility Options",
            "Dr Lasebikan/Dr Alabi/Dr Nwachukwu\n"
                "Prof Ikechebelu",
          ],
        ),

        CalendarElement(
          type: CalendarElementType.timedEvent,
          content: [
            "10:40 - 11:40",
            "TEA BREAK / BREAKOUT SESSION - "
                "Brachytherapy and Gyn Oncology - "
                "Prof Jhingran/ Breaking Bad news - "
                "Prof Okoye/Dr Otene/ Psycho-oncology - Dr Sarimiye/Dr Okwor",
          ],
        ),

        CalendarElement(
          content: [
            "11:45 - 12:30",
            "Dr Otene",
            "Pfizer Presentation",
            "Prof Bello/Prof Tessy Nwagha",
          ],
        ),

        CalendarElement(
          content: [
            "12:30 - 13:10",
            "Dr Nwachukwu",
            "Implementation science in cancer control an untapped opportunity for "
                "promoting equity in cancer prevention, training and research.\n"
                "Implementation science in cancer control an untapped opportunity for promoting equity in cancer prevention.",
            "Dr Ejemai Eboreime\n"
                "Prof Juliet Iwulemor",
          ],
        ),

        CalendarElement(
          content: [
            "13:10 - 14:10",
            "Dr Ntekim/Prof Adewuyi",
            "Best Of ASCO",
            "Marcelle Ruth Cancer Center",
          ],
        ),

        CalendarElement(
          type: CalendarElementType.timedEvent,
          content: [
            "14:10 - 14:40",
            "LUNCH",
          ],
        ),

        CalendarElement(
          content: [
            "14:40 - 15:40",
            "Dr Biyi-Olutunde",
            "Optimizing treatment in R/M SCCHN\n "
                "Clinical Cases - Best Practice sharing and management of ant-EGFR side effects",
            "Dr. Mohamed Suhail Anwar /King Faisal Specialist Hospital and Research Centre – Riyadh",
          ],
        ),

        CalendarElement(
          content: [
            "15:50 - 16:30",
            "Dr Joseph",
            "Paediatrics Oncology Session",
          ],
        ),

        CalendarElement(
          type: CalendarElementType.timedEvent,
          content: [
            "16:30 - 18:00",
            "TOUR TO RADIATION AND CLINICAL ONCOLOGY DEPARTMENT UNTH",
          ],
        ),
      ],
    );
  }

  Widget _dayThree() {
    return const CalendarItem(
      elements: [
        CalendarElement(
          type: CalendarElementType.lectureHeader2,
        ),

        CalendarElement(
          content: [
            "07:45 - 08:00",
            "Dr Orekoya",
            "Recap of Day 2",
            "",
          ],
        ),

        CalendarElement(
          content: [
            "08:00 - 08:50",
            "Dr Adegboyega/Dr Nuhu Tumba",
            "YOUNG ONCOLOGY FORUM",
            "Dr Otene\nDr Sarimiye/Dr Joseph\nDr Okunnuga"
          ],
        ),

        CalendarElement(
          content: [
            "08:50 - 09:50",
            "Prof Bello/Dr Alabi",
            "Best of ASCO",
            "Marcelle Ruth Cancer Center",
          ],
        ),

        CalendarElement(
          content: [
            "09:55 - 10:40",
            "Dr",
            "Overview of American Cancer Society's Project in Nigeria- UITH Ilorin Experience	",
            "American Cancer Society",
          ],
        ),

        CalendarElement(
          content: [
            "10:45 - 10:55",
            "Dr Okwor",
            "NCCN Harmonized guideline",
            "Dr Nwachukwu",
          ],
        ),

        CalendarElement(
          type: CalendarElementType.timedEvent,
          content: [
            "11:00 - 11:40",
            "TEA BREAK / BREAKOUT SESSION - "
                "Brachytherapy and Gyn Oncology - "
                "Prof Jhingran/ Breaking Bad news - "
                "Prof Okoye/Dr Otene/ Psycho-oncology - Dr Sarimiye/Dr Okwor",
          ],
        ),

        CalendarElement(
          content: [
            "11:40 - 12:50",
            "Dr Folasire/Dr Iloanusi",
            "Abstract Presentation",
            "EFFICACY OF WHOLE BRAIN RADIOTHERAPY AND SURVIVAL OUTCOME IN PATIENTS WITH BRAIN METASTASIS IN NSIA-LUTH CANCER CENTER.\n"
                "KNOWLEDGE OF BREAST AND CERVICAL CANCER AMONG FEMALE HIGH SCHOOL STUDENTS IN SOUTHEASTERN NIGERIA\n"
                "QUAD-SHOT TECHNIQUE IN PALLIATIVE RADIOTHERAPY TREATMENT OF HEAD AND NECK MALIGNANCIES: MARCELLE RUTH EXPERIENCE.\n"
                "BARRIERS OF CANCER PATIENTS TOWARD UTILIZATION OF PALLIATIVE CARE SERVICES AT UNIVERSITY COLLEGE HOSPITAL, IBADAN, NIGERIA. (PILOT STUDY)\n"
                "CING THE NIGERIAN ASSOCIATION OF MEDICAL PHYSICISTS AND HER COMMITMENT TO SAFE AND EFFECTIVE CANCER TREATMENT\n"
                "ANTIPROLIFERATIVE ACTIVITY OF EUPHORBIA INGENS EXTRACT AGAINST PROSTATE CANCER CELL LINE:\n"
                "Complete remission of diffuse B non-Hodgkiins Lymphomaof the nasopharynx by adjuvant Radiotherapy at the Muk and Maseb Radiothereapy Center in Kinshasha\n"
                "Multidisiplenary team approach to cancer care in UNTH; A quaterly Report",
          ],
        ),

        CalendarElement(
          content: [
            "11:40 - 12:50",
            "Dr Chukwuocha",
            "Introducing Pearl Oncology Specialist Hospital Innovation in Cancer care",
            "AN IN SILICO AND IN VITRO ANALYSIS",
          ],
        ),

        CalendarElement(
          content: [
            "13:25 - 13:55",
            "Dr",
            "Sponsored Session",
            "LUTH",
          ],
        ),

        CalendarElement(
          content: [
            "13:55 - 14:20",
            "Dr Mustapha",
            "Optimal Management of Metastatic Prostate Cancer: The place of novel Hormonal Therapy",
            "Janseen",
          ],
        ),

        CalendarElement(
          content: [
            "14:20 - 15:20",
            "Dr Adenipekun",
            "SEED GRANT REVIEWS",
            "Prof Ugwumba/Wong/Rotimi",
          ],
        ),

        CalendarElement(
          type: CalendarElementType.timedEvent,
          content: [
            "15:20 - 15:30",
            "CLOSING",
          ],
        ),

        CalendarElement(
          type: CalendarElementType.timedEvent,
          content: [
            "15:30 - 15:50",
            "LUNCH",
          ],
        ),

        CalendarElement(
          type: CalendarElementType.timedEvent,
          content: [
            "15:50 - 17:30",
            "ANNUAL GENERAL MEETING",
          ],
        ),

        CalendarElement(
          type: CalendarElementType.timedEvent,
          content: [
            "18:30 - 22:30",
            "DINNER",
          ],
        ),
      ],
    );
  }
}
