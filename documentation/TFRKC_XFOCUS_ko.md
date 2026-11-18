# 신규 16세력 국가중점 기본 구현 — 2026-11-16

사용자 최신 지시: 사용량을 아끼고 **기본적인 것만** 마무리합니다. 고유 시스템 본체·신규 전쟁·독립 사건·실행 테스트는 추가 제작하지 않습니다.

## 확인된 사항 / 창작 구현 / 미완 연결

**실제 확인:** docs/TFRKC_CITY_REGISTRY.json status=deployed와 실제 TFRKC 국가 태그 파일을 대조했습니다. 지상 15국 TAG가 존재합니다. UNDERGROUND는 tag=null 비영토 조직입니다. 기존 내전의 참가 플래그 TFRKC_participant, 진행/종결 플래그 TFRKC_civilwar_active / TFRKC_civilwar_finished를 읽습니다. 기존 7세력 중점·현지화·지도·전쟁·기초 파일을 수정하지 않았습니다. 그림은 설치된 TFRKP 원본 12종의 실제 정의·PNG·적용 우선순위·파일 해시를 확인해 참조합니다.

**이번 창작 구현:** 16트리 정의, 총291노드(지상15세력273개 + 서울지하 조직용18노드 설계), 국민정신65개, 한국어 제목·설명·효과 안내, 선행/배타/AI, 후발국 자동 배정입니다. 사용자의 정치 분기안을 독자 문안과 보상으로 구체화했습니다. 실존 지도자·신규 무기·부대·영토를 추가하지 않았습니다.

**미완 연결:** 조직 단계 디시전과 구매·식량·연구시험·공작·사면·담보 등 고유 시스템 본체는 이벤트/전쟁 담당 소유입니다. 각 준비 단계의 실제 완료 플래그와 32개 준비 트리거를 제공했으며 미존재 이벤트·공통 효과는 호출하지 않습니다. 현재 중점은 국내 준비 보상과 정치 선택까지만 실행합니다. 독립/등장 기능을 구현했다고 주장하지 않습니다.

서울지하는 국가 TAG가 없으므로 18개 중점 정의를 호스트 정부에 자동 할당하지 않습니다. 해당 정의는 비활성 상태이며, 실제 조직 단계는 요청표의 organizationNodes를 이벤트 담당의 디시전으로 변환해야 합니다. 호스트 전체에 지하 조직의 국민정신을 지급하지 않습니다. 지상/지하 중복 프로빈스도 없습니다.

## 세력별 기본 구조

| 세력 | 실제 TAG | 노드 수 | 정치 분기 | 고유 시스템 연결 준비 |
|---|---|---:|---|---|
| 광주시민방위정부 | KCG | 18 | 지방분권 공화국 / 강력한 비상정부 | 시민 방위와 지역의 동의 |
| 전주국민혁명위원회 | KJR | 18 | 민주적 혁명 / 영구혁명과 숙청 | 기억·혁명재판·지역 봉기 |
| 한국기업안보연합 | KCA | 18 | 기업 간 협약 / 단일 기업의 국가 장악 | 계열사 협약과 경비 계약 |
| 국가존속위원회 | KSC | 18 | 서울 정부 지원 / 정통성 승계 주장 | 기록·통신·행정 승계 |
| 태백산군사평의회 | KTM | 18 | 헌정세력 합류 / 독자 군사국가 | 고립 부대 연락과 산악 방어 |
| 호남농민공동전선 | KAF | 18 | 농민자치연방 / 전시농업국가 | 식량 공급 협약과 수매 |
| 새벽언약회 | KDC | 18 | 구호 공동체 / 종말론적 신정국가 | 구호시설·신도·교단 권력 |
| 자유대만복국군 | KTF | 18 | 한국 정착 / 대만 귀환 준비 | 망명 승인·항구·귀환 준비 |
| 대덕기술관리국 | KDT | 18 | 공공 연구체제 / 기술관료 통치 | 연구 보존·징발·실험 심사 |
| 대한철도공동체 | KRL | 18 | 중립 교통연방 / 철도 군벌 | 통행권·호송·거점 단절 |
| 백야국가보안국 | KBN | 18 | 민간정부에 권한 반환 / 비밀 통치체제 | 기밀·포섭·이중간첩 |
| 청송자유군 | KCS | 18 | 약속한 사면 이행 / 지휘부의 형량 통제 | 생존협약·사면·형량 약속 |
| 대한황실봉대회 | KHC | 21 | 입헌군주국 / 황제 친정 / 백제 계승 | 군주 추대·혈통 폭로·귀순 협상 |
| 서울지하자치구 | 비영토 조직 | 18 | 지상과 자치 협약 / 지상 진출 | 비영토 역장회의·자치 협상 |
| 망향군 | KMH | 18 | 전후 복귀 / 대중국 복수전 | 귀환장병·평화 요구·강화 갈등 |
| 국가채권회수단 | KBD | 18 | 채무 재조정 / 담보국가 건설 | 전쟁대출·채무불이행·담보 운영 |

공통 구조는 시작 → 민생·조직3개 / 방위3개 / 고유 운영 준비3개 / 정치회의와 배타 노선별3개 → 최종 운영안입니다. 황실은 정치 노선이3개라21노드입니다. 일반18노드와 황실21노드 모두 한 회차에15개를 완료할 수 있으며 기본 합계231일입니다. 중점의 일부만 완료해도 보상을 받습니다. 등장·개전·통일을 이 전체 완료에 묶지 않습니다.

긴급 수습7일, 연락·조직화14일, 제도/노선21일입니다. 후발 등장도 처음부터 진행할 수 있으며 개전 이후 일수나 고정 날짜 조건은 없습니다. 통일 뒤에도 국내 행정·정치 준비를 진행할 수 있고 전시 전용16개 국민정신만 실제 참가 종료에 따라 제거합니다. 모든 중점에 공장·인력·장비·부대 무료 생성은 없습니다. 운영 보상은 정치력/경험치와 세력 고유 국민정신을 중심으로 하며, 강압적 노선에는 안정·생산·민간 비용을 함께 둡니다.

## 자동 할당과 완료 기록

실제 등록 태그가 존재하고 항복하지 않았으며 최소 하나의 본인 소유·통제 주가 있을 때만 TFRKC_xfocus_bind_<KEY>_effect가 해당 국가의 트리를 불러옵니다. 전용 on_daily는 실제 신규15태그만 확인합니다. 국가 성립 뒤 다음 일일 틱에 적용될 수 있습니다. 기존 KOR 등 호스트에는 할당하지 않습니다. 중복 로드는 has_focus_tree 조건으로 방지합니다.

각 중점의 제목 키=ID, 설명 키=ID_desc, 완료 기록=ID_done입니다. 재완료 가드로 일회성 정치력·경험치의 중복 지급을 막습니다. bypass는 해당 중점을 실제 완료한 ID_done 기록이 있을 때만 작동합니다. 단순 노선 선택·전쟁 날짜·태그 존재로 자동 우회하지 않습니다.

정치 확정 플래그는 TFRKC_xfocus_policy_<KEY>_A/B/C입니다. route_a/b/c 완료가 확정 지점이며, 반대 플래그가 있으면 시작과 보상을 모두 거부합니다. TFRKC_xfocus_set_<KEY>_A/B/C_effect는 노선 상태만 설정하고 보상을 주지 않습니다. 같은 KEY의 identity 또는 organization 플래그가 있어야 호출됩니다. 조직→국가 전환은 이벤트 담당이 KEY별 정책과 완료 기록만 새 국가에 이관해야 합니다. 다른 조직의 기록을 복사하거나 일회성 보상을 재생하지 않습니다.

전시 국민정신은 실제 참가 플래그·내전 진행·미종결 상태를 모두 요구합니다. 진행하지 않은 중점의 아이디어는 재조정 효과가 지급하지 않습니다. 민생/정치 아이디어 복원도 합법적인 완료 기록과 해당 정책을 함께 검사합니다. 합병·항복·전 소유영토 상실 상태에서는 중점 보상을 지급하지 않습니다.

## 실제 파일

실제 적용 루트: `C:/Users/L/Documents/Paradox Interactive/Hearts of Iron IV/mod/tfrkc`

- `common/national_focus/TFRKC_xfocus_GWANGJU.txt`
- `common/national_focus/TFRKC_xfocus_JEONJU.txt`
- `common/national_focus/TFRKC_xfocus_CORPORATE.txt`
- `common/national_focus/TFRKC_xfocus_CONTINUITY.txt`
- `common/national_focus/TFRKC_xfocus_TAEBAEK.txt`
- `common/national_focus/TFRKC_xfocus_FARMERS.txt`
- `common/national_focus/TFRKC_xfocus_COVENANT.txt`
- `common/national_focus/TFRKC_xfocus_TAIWAN.txt`
- `common/national_focus/TFRKC_xfocus_DAEDEOK.txt`
- `common/national_focus/TFRKC_xfocus_RAIL.txt`
- `common/national_focus/TFRKC_xfocus_WHITE_NIGHT.txt`
- `common/national_focus/TFRKC_xfocus_CHEONGSONG.txt`
- `common/national_focus/TFRKC_xfocus_IMPERIAL.txt`
- `common/national_focus/TFRKC_xfocus_UNDERGROUND.txt`
- `common/national_focus/TFRKC_xfocus_HOMECOMING.txt`
- `common/national_focus/TFRKC_xfocus_CREDIT.txt`
- `common/scripted_triggers/TFRKC_xfocus_runtime.txt`
- `common/scripted_effects/TFRKC_xfocus_runtime.txt`
- `common/on_actions/TFRKC_xfocus_runtime.txt`
- `common/ideas/TFRKC_xfocus_ideas.txt`
- `localisation/korean/TFRKC_xfocus_l_korean.yml`
- `documentation/TFRKC_XFOCUS_IDS.json`
- `documentation/TFRKC_XFOCUS_REQUESTS.json`
- `documentation/TFRKC_XFOCUS_ko.md`
- `documentation/validation-xfocus.json`

작업공간 도구: tools/xfocus-data.cjs, build-xfocus.cjs, validate-xfocus.cjs, document-xfocus.cjs. 전용 파일만 생성하며 이전 7세력 빌더를 재실행하지 않았습니다. 동일 출력은 src에 보관했습니다.

## 이벤트·시스템 요청표

이벤트·스토리·전쟁·기초 담당 채팅에 실제 전달했습니다. 요청표 JSON에는 노선별 완료 지점, 호스트/국가 구분, 준비 트리거와 서울지하 전체18노드가 들어 있습니다. 아직 없는 사건/효과 ID는 빈 배열이며 호출 코드가 없습니다.

| 세력 | 요청 | 조건 | 기대 효과 / 담당 |
|---|---|---|---|
| 광주시민방위정부 | 타 지역 진출의 시민 위임 | 실제 주민 협의 · 상대 지역 통제·전투 상태 | 지역별 동의 기록과 진출 비용. 공짜 영토·봉기 생성 금지 / 이벤트·시스템 |
| 광주시민방위정부 | 전주와 공동전선·재판 갈등 | 양측 생존 · 실제 비적대 또는 협상 가능 | 공동전선 선택과 결별 사건; 전쟁 효과는 전쟁 담당으로 위임 / 이벤트·전쟁·스토리 |
| 전주국민혁명위원회 | 점령 지역 봉기 지원 | 실제 지역 통제·저항 상태 · 조직 비용 · 1회성·재사용 제한 | 실제 전쟁 담당 조건을 만족할 때만 봉기 지원 / 이벤트·전쟁 |
| 전주국민혁명위원회 | 혁명재판의 범위 | 광주 관계 · 민간 보호 원칙 · 선택 노선 | 민주적 절차 또는 숙청 확대로 갈등·고립·항복 협상 비용을 반영 / 이벤트·스토리 |
| 한국기업안보연합 | 유상 장비·용병 계약 | 실제 자금·재고 · 공급자 생존 · 납기·1회성 제한 | 실제 비용과 공급자 비축 차감을 수반하는 구매 / 이벤트·전쟁 |
| 한국기업안보연합 | 계열사 경쟁과 사병 지휘 | 선택 노선 · 계열사 충성·경쟁 상태 | 지휘권 분쟁 또는 공동 의결을 처리. 다른 기업 인물 임의 추가 금지 / 이벤트·시스템 |
| 국가존속위원회 | 서울 정부 지원 협의 | KOR 생존·비적대 · 실제 자원 비용 · 서로의 동의 | 원조·통신 지원의 유상 협의. 자동 합병·진영 가입 금지 / 이벤트·전쟁 |
| 국가존속위원회 | 정부 붕괴 후 승계 논쟁 | 서울 정부 상태 · 기록 보존 · 기존 헌정연합 관계 | 정통성 주장과 수락·거부를 처리, 영토/장교 이전은 공통 효과 / 이벤트·전쟁·스토리 |
| 태백산군사평의회 | 고립 부대 통합 | 실제 원소속 부대·인물 · 보급 가능 경로 · 상대 동의 또는 귀순 조건 | 실제 부대만 이전하고 원소속에서 차감 / 이벤트·전쟁 |
| 태백산군사평의회 | 헌정세력과 합류 협의 | KCH 생존·비적대 · 장교회의 노선 · 상호 동의 | 연락·공동전선·통합 여부를 별도 선택. 자동 합병 없음 / 이벤트·전쟁·스토리 |
| 호남농민공동전선 | 식량 공급 협정 | 실제 공급 여력 · 상대 생존 · 운송 가능 · 협정 비용 | 공급자 비용과 수령자 효과·기한을 갖는 협정 / 이벤트·시스템 |
| 호남농민공동전선 | 강제수매 갈등 | 수확/배급 상태 · 선택 노선 · 주민 반발 | 수매 확대와 지지 상실을 함께 처리. 무한 식량 판매 금지 / 이벤트·시스템 |
| 새벽언약회 | 구호시설 확대 | 실제 비용 · 민간 수용 여력 · 시설 위치 | 구호 제공과 공동체 지지, 비용·수용 제한을 함께 적용 / 이벤트·시스템 |
| 새벽언약회 | 교단 권력투쟁 | 윤어게인 관계 · 교단 노선 · 공동체 선택 | 종교적 권위와 대통령 지휘 충돌, 구호 자치 또는 신정 통제 / 이벤트·스토리 |
| 자유대만복국군 | 망명 정치조직 승인 | 상대 생존·대만 관련 외교 상태 · 당사자 동의 | 외교 승인과 정착 협의. 동맹 전체 참전 금지 / 이벤트·스토리 |
| 자유대만복국군 | 귀환 원정 준비 | 실제 항구·수송 능력 · 후원 동의 · 전후 상태 | 귀환 준비의 비용·목표만 확정. 함대 생성·자동 대중전 없음 / 이벤트·전쟁 |
| 대덕기술관리국 | 청소년해방군과 징발·독립 갈등 | 시설 실제 소유자 · 징발 상태 · 민간 연구진 선택 | 조직 또는 독립국의 등장 분기. 영토/병력은 공통 효과 / 이벤트·전쟁 |
| 대덕기술관리국 | 무인기·전자전·시제품 심사 | 실제 연구 능력·생산 비용 · 시험 성공/실패 · 사용 가능한 장비 정의 | 실제 생산·시험 비용과 실패 위험. 무료 미정의 장비 생성 금지 / 이벤트·시스템 |
| 대한철도공동체 | 유상 통행권과 호송 | 실제 연결된 철도 · 요금·기간·거래 상대 · 중립 상태 | 서로 동의한 통행과 호송 계약. 고립 거점 자동 연결 금지 / 이벤트·시스템 |
| 대한철도공동체 | 거점 단절과 운송 중단 | 실제 보급 경로 · 적대·협정 상태 · 민간 피해 | 단절을 실제 지도/전쟁 상태에 따라 처리. 무제한 봉쇄 금지 / 이벤트·전쟁 |
| 백야국가보안국 | 공작과 장교 포섭 | 실제 대상 인물·충성·비용 · 대상 생존 · 중복/배신 방지 | 성공·실패·노출 비용이 있는 포섭. 장군 복제 금지 / 이벤트·전쟁 |
| 백야국가보안국 | 이중간첩과 기밀 공개 | 노출 상태 · 반환/비밀통치 노선 | 내부 위기와 민간 감독/비밀권력의 대가 / 이벤트·스토리 |
| 청송자유군 | 사면에 따른 유상 충원과 약속 | 성인 지원자 · 약속 누적·실제 공로 · 중복·재모집 제한 | 사면 약속과 실제 충원·전후 이행 비용을 함께 관리 / 이벤트·전쟁 |
| 청송자유군 | 지휘부의 형량 통제 | 노선과 약속 상태 · 교도관/수감자 관계 | 공로 판정·사면 이행 또는 형량 통제 위기 / 이벤트·스토리 |
| 대한황실봉대회 | 혈통 조작 폭로 | 가상 군주만 사용 · 정책 확정 상태 · 증거 공개 여부 | 입헌·친정·백제 노선별 정당화와 위기. 실존 황족 임의 추가 금지 / 이벤트·스토리 |
| 대한황실봉대회 | 지역 귀순 협의 | 실제 상대·지역 · 상대 붕괴/합의 · 부대 차감 | 귀순을 실제 이전으로 처리. 공짜 코어·병력·영토 생성 금지 / 이벤트·전쟁 |
| 서울지하자치구 | 비영토 조직의 역장회의 | 실제 서울 지상 통제국 · 조직 활성화 · 호스트 변경 때 KEY별 상태 이관 | 중복 지상 프로빈스 없이 조직 디시전으로 운영. 이 18노드는 조직 단계 설계로 제공 / 이벤트·시스템 |
| 서울지하자치구 | 자치 협정 또는 지상 진출 | 지상 소유국 동의/갈등 · 실제 지상 거점 확보 · 전쟁 담당 공통 절차 | 협정의 권리·비용 또는 조건부 봉기. 지하 조직의 가상 TAG 생성 금지 / 이벤트·전쟁 |
| 망향군 | 강화협정 수용 또는 이탈 | 실제 평화 협정·동맹 · 부대/민간의 입장 · 선택 노선 | 강화 수용·협상 또는 별도 이탈 선택. 자동 선전포고 없음 / 이벤트·전쟁·스토리 |
| 망향군 | 귀환장병의 전후 복귀 | 실제 성인 장병 · 복귀 비용·치료 · 복수 요구 상태 | 실제 동원해제·재통합과 피로/복수 갈등 처리 / 이벤트·전쟁 |
| 국가채권회수단 | 유상 전쟁대출 | 실제 자금·채무자 동의 · 상환 기간·한도 · 동일 대출 중복 금지 | 실제 자금 이동과 채무 장부, 상환·연체 처리 / 이벤트·시스템 |
| 국가채권회수단 | 채무불이행과 운영권 | 유효 채권·불이행·상대 생존 · 담보 한도 · 기존 자산 소유 | 운영권과 영토 소유권을 구분. 강제 영토 이전은 공통 효과 / 이벤트·전쟁 |

각 요청의 readyTrigger는 해당 세력 identity/organization 플래그와 실제 준비 중점 완료 기록을 검사합니다. 디시전의 visible/available에서 사용할 수 있습니다. 준비 트리거 자체는 거래·봉기·참전을 실행하지 않습니다. 상세 ID는 TFRKC_XFOCUS_REQUESTS.json을 따릅니다.

## 전체 중점 ID·조건·보상·AI·선행 목록

공통 조건: 해당 세력 identity 플래그, 실제 존재, 비항복, 본인 소유·통제 주1개 이상. 노선 중점은 반대 정치 플래그 부재도 필요합니다. 제목·설명 원문, 실제 generatedReward와 전체 조건은 TFRKC_XFOCUS_IDS.json에 함께 있습니다. 아래 AND 선행은 각각 필요하며 OR 항목은 하나면 됩니다.

### 광주시민방위정부 — TFRKC_xfocus_GWANGJU_tree

| ID / 제목 | 기간 | 선행 AND | 선행 OR | 배타 | AI | 기본 보상 |
|---|---:|---|---|---|---:|---|
| TFRKC_xfocus_GWANGJU_start / 시청의 불을 켜다 | 7일 | 없음 | 없음 | 없음 | 100 | add_political_power = 25 |
| TFRKC_xfocus_GWANGJU_civic_1 / 골목의 대표들 | 7일 | TFRKC_xfocus_GWANGJU_start | 없음 | 없음 | 32 | add_stability = 0.03 |
| TFRKC_xfocus_GWANGJU_civic_2 / 서명받는 행정 | 14일 | TFRKC_xfocus_GWANGJU_civic_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_GWANGJU_idea_system |
| TFRKC_xfocus_GWANGJU_civic_3 / 광주 밖의 목소리 | 21일 | TFRKC_xfocus_GWANGJU_civic_2 | 없음 | 없음 | 14 | add_political_power = 20 add_stability = 0.02 |
| TFRKC_xfocus_GWANGJU_military_1 / 시민군의 구역표 | 7일 | TFRKC_xfocus_GWANGJU_start | 없음 | 없음 | 60 | army_experience = 8 |
| TFRKC_xfocus_GWANGJU_military_2 / 방어의 공통 언어 | 14일 | TFRKC_xfocus_GWANGJU_military_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_GWANGJU_idea_defence army_experience = 5 |
| TFRKC_xfocus_GWANGJU_military_3 / 골목을 넘어서는 훈련 | 21일 | TFRKC_xfocus_GWANGJU_military_2 | 없음 | 없음 | 14 | add_command_power = 10 |
| TFRKC_xfocus_GWANGJU_system_1 / 도시 간의 연락실 | 14일 | TFRKC_xfocus_GWANGJU_start | 없음 | 없음 | 14 | add_political_power = 20 |
| TFRKC_xfocus_GWANGJU_system_2 / 재판 기록의 공개 | 14일 | TFRKC_xfocus_GWANGJU_system_1 | 없음 | 없음 | 14 | add_stability = 0.03 add_war_support = -0.01 |
| TFRKC_xfocus_GWANGJU_system_3 / 위임장을 들고 가다 | 21일 | TFRKC_xfocus_GWANGJU_system_2 | 없음 | 없음 | 14 | add_political_power = 25 |
| TFRKC_xfocus_GWANGJU_council / 시민의 정부인가 | 14일 | TFRKC_xfocus_GWANGJU_start | 없음 | 없음 | 14 | add_political_power = 15 |
| TFRKC_xfocus_GWANGJU_route_a / 지역이 고르는 공화국 | 21일 | TFRKC_xfocus_GWANGJU_council | 없음 | TFRKC_xfocus_GWANGJU_route_b | 20 | add_ideas = TFRKC_xfocus_GWANGJU_idea_federal |
| TFRKC_xfocus_GWANGJU_route_b / 먼저 결정하는 비상정부 | 21일 | TFRKC_xfocus_GWANGJU_council | 없음 | TFRKC_xfocus_GWANGJU_route_a | 8 | add_ideas = TFRKC_xfocus_GWANGJU_idea_emergency |
| TFRKC_xfocus_GWANGJU_route_a_2 / 서로 다른 조례 | 14일 | TFRKC_xfocus_GWANGJU_route_a | 없음 | 없음 | 14 | add_stability = 0.03 add_political_power = 15 |
| TFRKC_xfocus_GWANGJU_route_b_2 / 지연 없는 결재선 | 14일 | TFRKC_xfocus_GWANGJU_route_b | 없음 | 없음 | 14 | add_command_power = 10 add_stability = -0.01 |
| TFRKC_xfocus_GWANGJU_route_a_3 / 거부할 수 있는 연방 | 21일 | TFRKC_xfocus_GWANGJU_route_a_2 | 없음 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |
| TFRKC_xfocus_GWANGJU_route_b_3 / 비상의 종료 조건 | 21일 | TFRKC_xfocus_GWANGJU_route_b_2 | 없음 | 없음 | 14 | army_experience = 8 add_political_power = 15 |
| TFRKC_xfocus_GWANGJU_settlement / 살아 있는 위임장 | 21일 | TFRKC_xfocus_GWANGJU_civic_3, TFRKC_xfocus_GWANGJU_military_3, TFRKC_xfocus_GWANGJU_system_3 | TFRKC_xfocus_GWANGJU_route_a_3 또는 TFRKC_xfocus_GWANGJU_route_b_3 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |

### 전주국민혁명위원회 — TFRKC_xfocus_JEONJU_tree

| ID / 제목 | 기간 | 선행 AND | 선행 OR | 배타 | AI | 기본 보상 |
|---|---:|---|---|---|---:|---|
| TFRKC_xfocus_JEONJU_start / 열세 이름의 도시 | 7일 | 없음 | 없음 | 없음 | 100 | add_political_power = 25 add_war_support = 0.02 |
| TFRKC_xfocus_JEONJU_civic_1 / 유가족의 기록함 | 7일 | TFRKC_xfocus_JEONJU_start | 없음 | 없음 | 32 | add_stability = 0.03 |
| TFRKC_xfocus_JEONJU_civic_2 / 사라지지 않는 증언 | 14일 | TFRKC_xfocus_JEONJU_civic_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_JEONJU_idea_system |
| TFRKC_xfocus_JEONJU_civic_3 / 새로운 일상의 청구서 | 21일 | TFRKC_xfocus_JEONJU_civic_2 | 없음 | 없음 | 14 | add_political_power = 25 |
| TFRKC_xfocus_JEONJU_military_1 / 성인 의용대의 연락 | 7일 | TFRKC_xfocus_JEONJU_start | 없음 | 없음 | 60 | army_experience = 8 |
| TFRKC_xfocus_JEONJU_military_2 / 구호 다음의 명령 | 14일 | TFRKC_xfocus_JEONJU_military_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_JEONJU_idea_columns army_experience = 5 |
| TFRKC_xfocus_JEONJU_military_3 / 후퇴도 보고하라 | 21일 | TFRKC_xfocus_JEONJU_military_2 | 없음 | 없음 | 14 | army_experience = 12 |
| TFRKC_xfocus_JEONJU_system_1 / 이웃 도시의 동지 | 14일 | TFRKC_xfocus_JEONJU_start | 없음 | 없음 | 14 | add_political_power = 20 |
| TFRKC_xfocus_JEONJU_system_2 / 재판의 방청석 | 14일 | TFRKC_xfocus_JEONJU_system_1 | 없음 | 없음 | 14 | add_political_power = 15 add_stability = 0.02 |
| TFRKC_xfocus_JEONJU_system_3 / 봉기에도 도착지가 있다 | 21일 | TFRKC_xfocus_JEONJU_system_2 | 없음 | 없음 | 14 | army_experience = 8 add_political_power = 10 |
| TFRKC_xfocus_JEONJU_council / 혁명의 끝을 묻다 | 14일 | TFRKC_xfocus_JEONJU_start | 없음 | 없음 | 14 | add_political_power = 15 |
| TFRKC_xfocus_JEONJU_route_a / 투표함으로 가는 혁명 | 21일 | TFRKC_xfocus_JEONJU_council | 없음 | TFRKC_xfocus_JEONJU_route_b | 20 | add_ideas = TFRKC_xfocus_JEONJU_idea_democratic |
| TFRKC_xfocus_JEONJU_route_b / 끝나지 않는 심판 | 21일 | TFRKC_xfocus_JEONJU_council | 없음 | TFRKC_xfocus_JEONJU_route_a | 8 | add_ideas = TFRKC_xfocus_JEONJU_idea_purge |
| TFRKC_xfocus_JEONJU_route_a_2 / 검찰보다 먼저 피고인 | 14일 | TFRKC_xfocus_JEONJU_route_a | 없음 | 없음 | 14 | add_stability = 0.03 add_war_support = -0.01 |
| TFRKC_xfocus_JEONJU_route_b_2 / 비어 있지 않은 감방 | 14일 | TFRKC_xfocus_JEONJU_route_b | 없음 | 없음 | 14 | add_war_support = 0.03 add_stability = -0.03 |
| TFRKC_xfocus_JEONJU_route_a_3 / 끝낼 수 있는 위원회 | 21일 | TFRKC_xfocus_JEONJU_route_a_2 | 없음 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |
| TFRKC_xfocus_JEONJU_route_b_3 / 항상 다음의 적 | 21일 | TFRKC_xfocus_JEONJU_route_b_2 | 없음 | 없음 | 14 | army_experience = 8 add_political_power = 10 add_stability = -0.01 |
| TFRKC_xfocus_JEONJU_settlement / 기억과 권력 사이 | 21일 | TFRKC_xfocus_JEONJU_civic_3, TFRKC_xfocus_JEONJU_military_3, TFRKC_xfocus_JEONJU_system_3 | TFRKC_xfocus_JEONJU_route_a_3 또는 TFRKC_xfocus_JEONJU_route_b_3 | 없음 | 14 | add_political_power = 25 add_stability = 0.01 |

### 한국기업안보연합 — TFRKC_xfocus_CORPORATE_tree

| ID / 제목 | 기간 | 선행 AND | 선행 OR | 배타 | AI | 기본 보상 |
|---|---:|---|---|---|---:|---|
| TFRKC_xfocus_CORPORATE_start / 비상 이사회 소집 | 7일 | 없음 | 없음 | 없음 | 100 | add_political_power = 30 |
| TFRKC_xfocus_CORPORATE_civic_1 / 지급일을 지키다 | 7일 | TFRKC_xfocus_CORPORATE_start | 없음 | 없음 | 32 | add_stability = 0.03 |
| TFRKC_xfocus_CORPORATE_civic_2 / 공동 정산실 | 14일 | TFRKC_xfocus_CORPORATE_civic_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_CORPORATE_idea_system |
| TFRKC_xfocus_CORPORATE_civic_3 / 공장 밖의 생활비 | 21일 | TFRKC_xfocus_CORPORATE_civic_2 | 없음 | 없음 | 14 | add_stability = 0.02 add_political_power = 20 |
| TFRKC_xfocus_CORPORATE_military_1 / 경비대의 호출부호 | 7일 | TFRKC_xfocus_CORPORATE_start | 없음 | 없음 | 60 | army_experience = 8 |
| TFRKC_xfocus_CORPORATE_military_2 / 계약된 지휘권 | 14일 | TFRKC_xfocus_CORPORATE_military_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_CORPORATE_idea_security army_experience = 5 |
| TFRKC_xfocus_CORPORATE_military_3 / 하청에 맡길 수 없는 것 | 21일 | TFRKC_xfocus_CORPORATE_military_2 | 없음 | 없음 | 14 | add_command_power = 10 |
| TFRKC_xfocus_CORPORATE_system_1 / 구매부의 전황판 | 14일 | TFRKC_xfocus_CORPORATE_start | 없음 | 없음 | 14 | add_political_power = 25 |
| TFRKC_xfocus_CORPORATE_system_2 / 돈이 도착하는 길 | 14일 | TFRKC_xfocus_CORPORATE_system_1 | 없음 | 없음 | 14 | add_political_power = 20 |
| TFRKC_xfocus_CORPORATE_system_3 / 사병의 주인은 누구인가 | 21일 | TFRKC_xfocus_CORPORATE_system_2 | 없음 | 없음 | 14 | army_experience = 8 add_political_power = 10 |
| TFRKC_xfocus_CORPORATE_council / 국가의 주주총회 | 14일 | TFRKC_xfocus_CORPORATE_start | 없음 | 없음 | 14 | add_political_power = 15 |
| TFRKC_xfocus_CORPORATE_route_a / 서로의 계약서 | 21일 | TFRKC_xfocus_CORPORATE_council | 없음 | TFRKC_xfocus_CORPORATE_route_b | 20 | add_ideas = TFRKC_xfocus_CORPORATE_idea_compact |
| TFRKC_xfocus_CORPORATE_route_b / 단 하나의 직인 | 21일 | TFRKC_xfocus_CORPORATE_council | 없음 | TFRKC_xfocus_CORPORATE_route_a | 8 | add_ideas = TFRKC_xfocus_CORPORATE_idea_monopoly |
| TFRKC_xfocus_CORPORATE_route_a_2 / 분쟁조정 창구 | 14일 | TFRKC_xfocus_CORPORATE_route_a | 없음 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |
| TFRKC_xfocus_CORPORATE_route_b_2 / 모든 도로가 본사로 | 14일 | TFRKC_xfocus_CORPORATE_route_b | 없음 | 없음 | 14 | add_command_power = 10 add_stability = -0.02 |
| TFRKC_xfocus_CORPORATE_route_a_3 / 협약이 보장하는 퇴장 | 21일 | TFRKC_xfocus_CORPORATE_route_a_2 | 없음 | 없음 | 14 | add_political_power = 20 add_stability = 0.03 |
| TFRKC_xfocus_CORPORATE_route_b_3 / 사표 없는 경영진 | 21일 | TFRKC_xfocus_CORPORATE_route_b_2 | 없음 | 없음 | 14 | add_political_power = 30 add_stability = -0.01 |
| TFRKC_xfocus_CORPORATE_settlement / 전후의 결산서 | 21일 | TFRKC_xfocus_CORPORATE_civic_3, TFRKC_xfocus_CORPORATE_military_3, TFRKC_xfocus_CORPORATE_system_3 | TFRKC_xfocus_CORPORATE_route_a_3 또는 TFRKC_xfocus_CORPORATE_route_b_3 | 없음 | 14 | add_political_power = 25 add_stability = 0.01 |

### 국가존속위원회 — TFRKC_xfocus_CONTINUITY_tree

| ID / 제목 | 기간 | 선행 AND | 선행 OR | 배타 | AI | 기본 보상 |
|---|---:|---|---|---|---:|---|
| TFRKC_xfocus_CONTINUITY_start / 정부가 없어도 서류는 | 7일 | 없음 | 없음 | 없음 | 100 | add_political_power = 30 |
| TFRKC_xfocus_CONTINUITY_civic_1 / 남아 있는 공무원 | 7일 | TFRKC_xfocus_CONTINUITY_start | 없음 | 없음 | 32 | add_stability = 0.03 |
| TFRKC_xfocus_CONTINUITY_civic_2 / 기록의 두 번째 집 | 14일 | TFRKC_xfocus_CONTINUITY_civic_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_CONTINUITY_idea_system |
| TFRKC_xfocus_CONTINUITY_civic_3 / 어제의 민원 번호 | 21일 | TFRKC_xfocus_CONTINUITY_civic_2 | 없음 | 없음 | 14 | add_stability = 0.02 add_political_power = 20 |
| TFRKC_xfocus_CONTINUITY_military_1 / 청사 방호병력 점검 | 7일 | TFRKC_xfocus_CONTINUITY_start | 없음 | 없음 | 60 | army_experience = 8 |
| TFRKC_xfocus_CONTINUITY_military_2 / 문서를 지키는 전선 | 14일 | TFRKC_xfocus_CONTINUITY_military_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_CONTINUITY_idea_guards army_experience = 5 |
| TFRKC_xfocus_CONTINUITY_military_3 / 통신실의 야간근무 | 21일 | TFRKC_xfocus_CONTINUITY_military_2 | 없음 | 없음 | 14 | add_command_power = 10 |
| TFRKC_xfocus_CONTINUITY_system_1 / 서울로 보내는 전문 | 14일 | TFRKC_xfocus_CONTINUITY_start | 없음 | 없음 | 14 | add_political_power = 20 |
| TFRKC_xfocus_CONTINUITY_system_2 / 지원도 결재가 필요하다 | 14일 | TFRKC_xfocus_CONTINUITY_system_1 | 없음 | 없음 | 14 | add_political_power = 25 |
| TFRKC_xfocus_CONTINUITY_system_3 / 관료의 소속을 묻다 | 21일 | TFRKC_xfocus_CONTINUITY_system_2 | 없음 | 없음 | 14 | army_experience = 8 add_political_power = 10 |
| TFRKC_xfocus_CONTINUITY_council / 직인은 누구의 것인가 | 14일 | TFRKC_xfocus_CONTINUITY_start | 없음 | 없음 | 14 | add_political_power = 15 |
| TFRKC_xfocus_CONTINUITY_route_a / 서울이 답할 때까지 | 21일 | TFRKC_xfocus_CONTINUITY_council | 없음 | TFRKC_xfocus_CONTINUITY_route_b | 20 | add_ideas = TFRKC_xfocus_CONTINUITY_idea_service |
| TFRKC_xfocus_CONTINUITY_route_b / 우리가 국가를 잇는다 | 21일 | TFRKC_xfocus_CONTINUITY_council | 없음 | TFRKC_xfocus_CONTINUITY_route_a | 8 | add_ideas = TFRKC_xfocus_CONTINUITY_idea_claim |
| TFRKC_xfocus_CONTINUITY_route_a_2 / 권한보다 먼저 책임 | 14일 | TFRKC_xfocus_CONTINUITY_route_a | 없음 | 없음 | 14 | add_stability = 0.03 add_political_power = 15 |
| TFRKC_xfocus_CONTINUITY_route_b_2 / 국가의 이름을 고치다 | 14일 | TFRKC_xfocus_CONTINUITY_route_b | 없음 | 없음 | 14 | add_political_power = 30 add_stability = -0.01 |
| TFRKC_xfocus_CONTINUITY_route_a_3 / 같은 헌법의 사본 | 21일 | TFRKC_xfocus_CONTINUITY_route_a_2 | 없음 | 없음 | 14 | add_political_power = 20 add_stability = 0.02 |
| TFRKC_xfocus_CONTINUITY_route_b_3 / 승계에도 동의가 필요하다 | 21일 | TFRKC_xfocus_CONTINUITY_route_b_2 | 없음 | 없음 | 14 | add_political_power = 20 add_stability = 0.01 |
| TFRKC_xfocus_CONTINUITY_settlement / 폐기하지 않을 기록 | 21일 | TFRKC_xfocus_CONTINUITY_civic_3, TFRKC_xfocus_CONTINUITY_military_3, TFRKC_xfocus_CONTINUITY_system_3 | TFRKC_xfocus_CONTINUITY_route_a_3 또는 TFRKC_xfocus_CONTINUITY_route_b_3 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |

### 태백산군사평의회 — TFRKC_xfocus_TAEBAEK_tree

| ID / 제목 | 기간 | 선행 AND | 선행 OR | 배타 | AI | 기본 보상 |
|---|---:|---|---|---|---:|---|
| TFRKC_xfocus_TAEBAEK_start / 산 너머의 호출 | 7일 | 없음 | 없음 | 없음 | 100 | add_political_power = 20 army_experience = 5 |
| TFRKC_xfocus_TAEBAEK_civic_1 / 골짜기의 연락초소 | 7일 | TFRKC_xfocus_TAEBAEK_start | 없음 | 없음 | 32 | add_stability = 0.03 |
| TFRKC_xfocus_TAEBAEK_civic_2 / 끊긴 도로의 장부 | 14일 | TFRKC_xfocus_TAEBAEK_civic_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_TAEBAEK_idea_system |
| TFRKC_xfocus_TAEBAEK_civic_3 / 군정청의 민원 시간 | 21일 | TFRKC_xfocus_TAEBAEK_civic_2 | 없음 | 없음 | 14 | add_political_power = 20 add_stability = 0.02 |
| TFRKC_xfocus_TAEBAEK_military_1 / 능선을 읽는 장교들 | 7일 | TFRKC_xfocus_TAEBAEK_start | 없음 | 없음 | 60 | army_experience = 10 |
| TFRKC_xfocus_TAEBAEK_military_2 / 자리를 지키는 훈련 | 14일 | TFRKC_xfocus_TAEBAEK_military_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_TAEBAEK_idea_mountain army_experience = 5 |
| TFRKC_xfocus_TAEBAEK_military_3 / 노획품의 출처 | 21일 | TFRKC_xfocus_TAEBAEK_military_2 | 없음 | 없음 | 14 | army_experience = 12 |
| TFRKC_xfocus_TAEBAEK_system_1 / 응답 없는 부대 | 14일 | TFRKC_xfocus_TAEBAEK_start | 없음 | 없음 | 14 | add_political_power = 20 |
| TFRKC_xfocus_TAEBAEK_system_2 / 돌아오는 명령서 | 14일 | TFRKC_xfocus_TAEBAEK_system_1 | 없음 | 없음 | 14 | army_experience = 8 add_political_power = 10 |
| TFRKC_xfocus_TAEBAEK_system_3 / 같은 헌법의 무전 | 21일 | TFRKC_xfocus_TAEBAEK_system_2 | 없음 | 없음 | 14 | add_political_power = 25 |
| TFRKC_xfocus_TAEBAEK_council / 장교회의의 표결 | 14일 | TFRKC_xfocus_TAEBAEK_start | 없음 | 없음 | 14 | add_political_power = 15 |
| TFRKC_xfocus_TAEBAEK_route_a / 헌정의 편에 서다 | 21일 | TFRKC_xfocus_TAEBAEK_council | 없음 | TFRKC_xfocus_TAEBAEK_route_b | 20 | add_ideas = TFRKC_xfocus_TAEBAEK_idea_constitution |
| TFRKC_xfocus_TAEBAEK_route_b / 산에서 세우는 국가 | 21일 | TFRKC_xfocus_TAEBAEK_council | 없음 | TFRKC_xfocus_TAEBAEK_route_a | 8 | add_ideas = TFRKC_xfocus_TAEBAEK_idea_garrison |
| TFRKC_xfocus_TAEBAEK_route_a_2 / 민간 앞의 작전 보고 | 14일 | TFRKC_xfocus_TAEBAEK_route_a | 없음 | 없음 | 14 | add_stability = 0.03 add_political_power = 15 |
| TFRKC_xfocus_TAEBAEK_route_b_2 / 명령의 관할구역 | 14일 | TFRKC_xfocus_TAEBAEK_route_b | 없음 | 없음 | 14 | add_command_power = 10 add_stability = -0.01 |
| TFRKC_xfocus_TAEBAEK_route_a_3 / 합류 뒤에도 지킬 것 | 21일 | TFRKC_xfocus_TAEBAEK_route_a_2 | 없음 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |
| TFRKC_xfocus_TAEBAEK_route_b_3 / 군복을 벗지 않는 권력 | 21일 | TFRKC_xfocus_TAEBAEK_route_b_2 | 없음 | 없음 | 14 | army_experience = 8 add_political_power = 15 |
| TFRKC_xfocus_TAEBAEK_settlement / 봄이 오는 능선 | 21일 | TFRKC_xfocus_TAEBAEK_civic_3, TFRKC_xfocus_TAEBAEK_military_3, TFRKC_xfocus_TAEBAEK_system_3 | TFRKC_xfocus_TAEBAEK_route_a_3 또는 TFRKC_xfocus_TAEBAEK_route_b_3 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |

### 호남농민공동전선 — TFRKC_xfocus_FARMERS_tree

| ID / 제목 | 기간 | 선행 AND | 선행 OR | 배타 | AI | 기본 보상 |
|---|---:|---|---|---|---:|---|
| TFRKC_xfocus_FARMERS_start / 도시의 전쟁, 우리의 밭 | 7일 | 없음 | 없음 | 없음 | 100 | add_political_power = 25 |
| TFRKC_xfocus_FARMERS_civic_1 / 마을마다 남는 몫 | 7일 | TFRKC_xfocus_FARMERS_start | 없음 | 없음 | 32 | add_stability = 0.03 |
| TFRKC_xfocus_FARMERS_civic_2 / 공동 수매장의 저울 | 14일 | TFRKC_xfocus_FARMERS_civic_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_FARMERS_idea_system |
| TFRKC_xfocus_FARMERS_civic_3 / 농촌의 진료일 | 21일 | TFRKC_xfocus_FARMERS_civic_2 | 없음 | 없음 | 14 | add_stability = 0.03 add_political_power = 15 |
| TFRKC_xfocus_FARMERS_military_1 / 논두렁의 성인 방위대 | 7일 | TFRKC_xfocus_FARMERS_start | 없음 | 없음 | 60 | army_experience = 8 |
| TFRKC_xfocus_FARMERS_military_2 / 익숙한 길의 보급 | 14일 | TFRKC_xfocus_FARMERS_military_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_FARMERS_idea_local_guards army_experience = 5 |
| TFRKC_xfocus_FARMERS_military_3 / 수확철의 교대표 | 21일 | TFRKC_xfocus_FARMERS_military_2 | 없음 | 없음 | 14 | army_experience = 12 |
| TFRKC_xfocus_FARMERS_system_1 / 창고 앞의 협상 | 14일 | TFRKC_xfocus_FARMERS_start | 없음 | 없음 | 14 | add_political_power = 20 |
| TFRKC_xfocus_FARMERS_system_2 / 식량에도 운송비가 있다 | 14일 | TFRKC_xfocus_FARMERS_system_1 | 없음 | 없음 | 14 | add_political_power = 25 |
| TFRKC_xfocus_FARMERS_system_3 / 밭을 비운 사람들 | 21일 | TFRKC_xfocus_FARMERS_system_2 | 없음 | 없음 | 14 | add_stability = 0.02 add_political_power = 15 |
| TFRKC_xfocus_FARMERS_council / 누가 저울을 쥐는가 | 14일 | TFRKC_xfocus_FARMERS_start | 없음 | 없음 | 14 | add_political_power = 15 |
| TFRKC_xfocus_FARMERS_route_a / 농민자치연방 | 21일 | TFRKC_xfocus_FARMERS_council | 없음 | TFRKC_xfocus_FARMERS_route_b | 20 | add_ideas = TFRKC_xfocus_FARMERS_idea_federation |
| TFRKC_xfocus_FARMERS_route_b / 전시농업국가 | 21일 | TFRKC_xfocus_FARMERS_council | 없음 | TFRKC_xfocus_FARMERS_route_a | 8 | add_ideas = TFRKC_xfocus_FARMERS_idea_agrostate |
| TFRKC_xfocus_FARMERS_route_a_2 / 협정의 최소 가격 | 14일 | TFRKC_xfocus_FARMERS_route_a | 없음 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |
| TFRKC_xfocus_FARMERS_route_b_2 / 수매 명령의 집행부 | 14일 | TFRKC_xfocus_FARMERS_route_b | 없음 | 없음 | 14 | add_political_power = 25 add_stability = -0.02 |
| TFRKC_xfocus_FARMERS_route_a_3 / 씨앗을 남기는 연방 | 21일 | TFRKC_xfocus_FARMERS_route_a_2 | 없음 | 없음 | 14 | add_stability = 0.03 add_political_power = 15 |
| TFRKC_xfocus_FARMERS_route_b_3 / 배급국의 다음 해 | 21일 | TFRKC_xfocus_FARMERS_route_b_2 | 없음 | 없음 | 14 | army_experience = 5 add_political_power = 20 |
| TFRKC_xfocus_FARMERS_settlement / 다음 해에도 심을 것 | 21일 | TFRKC_xfocus_FARMERS_civic_3, TFRKC_xfocus_FARMERS_military_3, TFRKC_xfocus_FARMERS_system_3 | TFRKC_xfocus_FARMERS_route_a_3 또는 TFRKC_xfocus_FARMERS_route_b_3 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |

### 새벽언약회 — TFRKC_xfocus_COVENANT_tree

| ID / 제목 | 기간 | 선행 AND | 선행 OR | 배타 | AI | 기본 보상 |
|---|---:|---|---|---|---:|---|
| TFRKC_xfocus_COVENANT_start / 새벽에 열린 문 | 7일 | 없음 | 없음 | 없음 | 100 | add_political_power = 20 add_stability = 0.02 |
| TFRKC_xfocus_COVENANT_civic_1 / 한 사람분의 그릇 | 7일 | TFRKC_xfocus_COVENANT_start | 없음 | 없음 | 32 | add_stability = 0.03 |
| TFRKC_xfocus_COVENANT_civic_2 / 불 꺼지지 않는 시설 | 14일 | TFRKC_xfocus_COVENANT_civic_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_COVENANT_idea_system |
| TFRKC_xfocus_COVENANT_civic_3 / 예배 뒤의 민원 | 21일 | TFRKC_xfocus_COVENANT_civic_2 | 없음 | 없음 | 14 | add_political_power = 20 add_stability = 0.02 |
| TFRKC_xfocus_COVENANT_military_1 / 성인 호송대의 약속 | 7일 | TFRKC_xfocus_COVENANT_start | 없음 | 없음 | 60 | army_experience = 8 |
| TFRKC_xfocus_COVENANT_military_2 / 길을 지키는 규율 | 14일 | TFRKC_xfocus_COVENANT_military_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_COVENANT_idea_stewards army_experience = 5 |
| TFRKC_xfocus_COVENANT_military_3 / 기도만으로 오지 않는 약 | 21일 | TFRKC_xfocus_COVENANT_military_2 | 없음 | 없음 | 14 | add_command_power = 10 |
| TFRKC_xfocus_COVENANT_system_1 / 더 많은 문을 열려면 | 14일 | TFRKC_xfocus_COVENANT_start | 없음 | 없음 | 14 | add_political_power = 20 |
| TFRKC_xfocus_COVENANT_system_2 / 구호의 조건 | 14일 | TFRKC_xfocus_COVENANT_system_1 | 없음 | 없음 | 14 | add_stability = 0.03 add_political_power = 15 |
| TFRKC_xfocus_COVENANT_system_3 / 누구의 명령을 듣는가 | 21일 | TFRKC_xfocus_COVENANT_system_2 | 없음 | 없음 | 14 | add_political_power = 25 |
| TFRKC_xfocus_COVENANT_council / 종말 뒤의 이웃 | 14일 | TFRKC_xfocus_COVENANT_start | 없음 | 없음 | 14 | add_political_power = 15 |
| TFRKC_xfocus_COVENANT_route_a / 믿음보다 먼저 사람 | 21일 | TFRKC_xfocus_COVENANT_council | 없음 | TFRKC_xfocus_COVENANT_route_b | 20 | add_ideas = TFRKC_xfocus_COVENANT_idea_community |
| TFRKC_xfocus_COVENANT_route_b / 계시를 적는 관청 | 21일 | TFRKC_xfocus_COVENANT_council | 없음 | TFRKC_xfocus_COVENANT_route_a | 8 | add_ideas = TFRKC_xfocus_COVENANT_idea_theocracy |
| TFRKC_xfocus_COVENANT_route_a_2 / 열린 구호위원회 | 14일 | TFRKC_xfocus_COVENANT_route_a | 없음 | 없음 | 14 | add_stability = 0.03 add_political_power = 15 |
| TFRKC_xfocus_COVENANT_route_b_2 / 의심 없는 보고서 | 14일 | TFRKC_xfocus_COVENANT_route_b | 없음 | 없음 | 14 | add_war_support = 0.03 add_stability = -0.02 |
| TFRKC_xfocus_COVENANT_route_a_3 / 문을 닫지 않는 언약 | 21일 | TFRKC_xfocus_COVENANT_route_a_2 | 없음 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |
| TFRKC_xfocus_COVENANT_route_b_3 / 영원한 새벽의 질서 | 21일 | TFRKC_xfocus_COVENANT_route_b_2 | 없음 | 없음 | 14 | add_political_power = 25 add_stability = -0.01 |
| TFRKC_xfocus_COVENANT_settlement / 날이 밝은 뒤에도 | 21일 | TFRKC_xfocus_COVENANT_civic_3, TFRKC_xfocus_COVENANT_military_3, TFRKC_xfocus_COVENANT_system_3 | TFRKC_xfocus_COVENANT_route_a_3 또는 TFRKC_xfocus_COVENANT_route_b_3 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |

### 자유대만복국군 — TFRKC_xfocus_TAIWAN_tree

| ID / 제목 | 기간 | 선행 AND | 선행 OR | 배타 | AI | 기본 보상 |
|---|---:|---|---|---|---:|---|
| TFRKC_xfocus_TAIWAN_start / 항구에 남은 사람들 | 7일 | 없음 | 없음 | 없음 | 100 | add_political_power = 20 add_stability = 0.02 |
| TFRKC_xfocus_TAIWAN_civic_1 / 망명 가족의 명부 | 7일 | TFRKC_xfocus_TAIWAN_start | 없음 | 없음 | 32 | add_stability = 0.03 |
| TFRKC_xfocus_TAIWAN_civic_2 / 타지의 생활망 | 14일 | TFRKC_xfocus_TAIWAN_civic_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_TAIWAN_idea_system |
| TFRKC_xfocus_TAIWAN_civic_3 / 번역되는 일상 | 21일 | TFRKC_xfocus_TAIWAN_civic_2 | 없음 | 없음 | 14 | add_political_power = 20 add_stability = 0.02 |
| TFRKC_xfocus_TAIWAN_military_1 / 남은 간부들의 회의 | 7일 | TFRKC_xfocus_TAIWAN_start | 없음 | 없음 | 60 | army_experience = 10 |
| TFRKC_xfocus_TAIWAN_military_2 / 숙련을 넘겨주다 | 14일 | TFRKC_xfocus_TAIWAN_military_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_TAIWAN_idea_cadres army_experience = 5 |
| TFRKC_xfocus_TAIWAN_military_3 / 낯선 전장의 지도 | 21일 | TFRKC_xfocus_TAIWAN_military_2 | 없음 | 없음 | 14 | army_experience = 8 air_experience = 5 |
| TFRKC_xfocus_TAIWAN_system_1 / 돌아갈 주소 | 14일 | TFRKC_xfocus_TAIWAN_start | 없음 | 없음 | 14 | add_political_power = 20 |
| TFRKC_xfocus_TAIWAN_system_2 / 망명자의 대표권 | 14일 | TFRKC_xfocus_TAIWAN_system_1 | 없음 | 없음 | 14 | add_political_power = 25 |
| TFRKC_xfocus_TAIWAN_system_3 / 항구의 실제 능력 | 21일 | TFRKC_xfocus_TAIWAN_system_2 | 없음 | 없음 | 14 | navy_experience = 8 |
| TFRKC_xfocus_TAIWAN_council / 남을 것인가 돌아갈 것인가 | 14일 | TFRKC_xfocus_TAIWAN_start | 없음 | 없음 | 14 | add_political_power = 15 |
| TFRKC_xfocus_TAIWAN_route_a / 이곳에도 내일이 있다 | 21일 | TFRKC_xfocus_TAIWAN_council | 없음 | TFRKC_xfocus_TAIWAN_route_b | 20 | add_ideas = TFRKC_xfocus_TAIWAN_idea_settlement |
| TFRKC_xfocus_TAIWAN_route_b / 돌아갈 날을 준비하다 | 21일 | TFRKC_xfocus_TAIWAN_council | 없음 | TFRKC_xfocus_TAIWAN_route_a | 8 | add_ideas = TFRKC_xfocus_TAIWAN_idea_return_plan |
| TFRKC_xfocus_TAIWAN_route_a_2 / 같은 골목의 이웃 | 14일 | TFRKC_xfocus_TAIWAN_route_a | 없음 | 없음 | 14 | add_stability = 0.03 add_political_power = 15 |
| TFRKC_xfocus_TAIWAN_route_b_2 / 수송 계획의 첫 장 | 14일 | TFRKC_xfocus_TAIWAN_route_b | 없음 | 없음 | 14 | navy_experience = 10 add_political_power = 10 |
| TFRKC_xfocus_TAIWAN_route_a_3 / 함께 남는 기록 | 21일 | TFRKC_xfocus_TAIWAN_route_a_2 | 없음 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |
| TFRKC_xfocus_TAIWAN_route_b_3 / 바다 건너의 조건 | 21일 | TFRKC_xfocus_TAIWAN_route_b_2 | 없음 | 없음 | 14 | navy_experience = 8 add_political_power = 15 |
| TFRKC_xfocus_TAIWAN_settlement / 짐을 푸는 방식 | 21일 | TFRKC_xfocus_TAIWAN_civic_3, TFRKC_xfocus_TAIWAN_military_3, TFRKC_xfocus_TAIWAN_system_3 | TFRKC_xfocus_TAIWAN_route_a_3 또는 TFRKC_xfocus_TAIWAN_route_b_3 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |

### 대덕기술관리국 — TFRKC_xfocus_DAEDEOK_tree

| ID / 제목 | 기간 | 선행 AND | 선행 OR | 배타 | AI | 기본 보상 |
|---|---:|---|---|---|---:|---|
| TFRKC_xfocus_DAEDEOK_start / 연구노트의 대피 | 7일 | 없음 | 없음 | 없음 | 100 | add_political_power = 25 |
| TFRKC_xfocus_DAEDEOK_civic_1 / 실험실 밖의 사람들 | 7일 | TFRKC_xfocus_DAEDEOK_start | 없음 | 없음 | 32 | add_stability = 0.03 |
| TFRKC_xfocus_DAEDEOK_civic_2 / 다음 장을 남기다 | 14일 | TFRKC_xfocus_DAEDEOK_civic_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_DAEDEOK_idea_system |
| TFRKC_xfocus_DAEDEOK_civic_3 / 전력과 냉각수의 예산 | 21일 | TFRKC_xfocus_DAEDEOK_civic_2 | 없음 | 없음 | 14 | add_political_power = 20 add_stability = 0.02 |
| TFRKC_xfocus_DAEDEOK_military_1 / 경비대와 연구진 사이 | 7일 | TFRKC_xfocus_DAEDEOK_start | 없음 | 없음 | 60 | army_experience = 8 |
| TFRKC_xfocus_DAEDEOK_military_2 / 교신을 시험하다 | 14일 | TFRKC_xfocus_DAEDEOK_military_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_DAEDEOK_idea_signals air_experience = 5 |
| TFRKC_xfocus_DAEDEOK_military_3 / 시험비행의 기록 | 21일 | TFRKC_xfocus_DAEDEOK_military_2 | 없음 | 없음 | 14 | air_experience = 12 |
| TFRKC_xfocus_DAEDEOK_system_1 / 징발 명령의 서명 | 14일 | TFRKC_xfocus_DAEDEOK_start | 없음 | 없음 | 14 | add_political_power = 20 |
| TFRKC_xfocus_DAEDEOK_system_2 / 시설의 주인을 묻다 | 14일 | TFRKC_xfocus_DAEDEOK_system_1 | 없음 | 없음 | 14 | add_political_power = 15 add_stability = 0.02 |
| TFRKC_xfocus_DAEDEOK_system_3 / 시제품은 보고서가 아니다 | 21일 | TFRKC_xfocus_DAEDEOK_system_2 | 없음 | 없음 | 14 | air_experience = 10 |
| TFRKC_xfocus_DAEDEOK_council / 누가 실험을 승인하는가 | 14일 | TFRKC_xfocus_DAEDEOK_start | 없음 | 없음 | 14 | add_political_power = 15 |
| TFRKC_xfocus_DAEDEOK_route_a / 공공의 연구실 | 21일 | TFRKC_xfocus_DAEDEOK_council | 없음 | TFRKC_xfocus_DAEDEOK_route_b | 20 | add_ideas = TFRKC_xfocus_DAEDEOK_idea_public |
| TFRKC_xfocus_DAEDEOK_route_b / 국가를 설계하는 사람들 | 21일 | TFRKC_xfocus_DAEDEOK_council | 없음 | TFRKC_xfocus_DAEDEOK_route_a | 8 | add_ideas = TFRKC_xfocus_DAEDEOK_idea_technocrat |
| TFRKC_xfocus_DAEDEOK_route_a_2 / 실패를 공개할 권리 | 14일 | TFRKC_xfocus_DAEDEOK_route_a | 없음 | 없음 | 14 | add_political_power = 20 add_stability = 0.03 |
| TFRKC_xfocus_DAEDEOK_route_b_2 / 측정되지 않은 민원 | 14일 | TFRKC_xfocus_DAEDEOK_route_b | 없음 | 없음 | 14 | add_political_power = 25 add_stability = -0.01 |
| TFRKC_xfocus_DAEDEOK_route_a_3 / 주민 앞의 연구윤리 | 21일 | TFRKC_xfocus_DAEDEOK_route_a_2 | 없음 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |
| TFRKC_xfocus_DAEDEOK_route_b_3 / 관리국의 장기 실험 | 21일 | TFRKC_xfocus_DAEDEOK_route_b_2 | 없음 | 없음 | 14 | air_experience = 8 add_political_power = 15 |
| TFRKC_xfocus_DAEDEOK_settlement / 보존할 기술, 지킬 사람 | 21일 | TFRKC_xfocus_DAEDEOK_civic_3, TFRKC_xfocus_DAEDEOK_military_3, TFRKC_xfocus_DAEDEOK_system_3 | TFRKC_xfocus_DAEDEOK_route_a_3 또는 TFRKC_xfocus_DAEDEOK_route_b_3 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |

### 대한철도공동체 — TFRKC_xfocus_RAIL_tree

| ID / 제목 | 기간 | 선행 AND | 선행 OR | 배타 | AI | 기본 보상 |
|---|---:|---|---|---|---:|---|
| TFRKC_xfocus_RAIL_start / 마지막 열차의 직원들 | 7일 | 없음 | 없음 | 없음 | 100 | add_political_power = 25 |
| TFRKC_xfocus_RAIL_civic_1 / 역마다 남은 명부 | 7일 | TFRKC_xfocus_RAIL_start | 없음 | 없음 | 32 | add_stability = 0.03 |
| TFRKC_xfocus_RAIL_civic_2 / 같은 시간의 역무실 | 14일 | TFRKC_xfocus_RAIL_civic_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_RAIL_idea_system |
| TFRKC_xfocus_RAIL_civic_3 / 정차역의 식탁 | 21일 | TFRKC_xfocus_RAIL_civic_2 | 없음 | 없음 | 14 | add_stability = 0.03 add_political_power = 15 |
| TFRKC_xfocus_RAIL_military_1 / 성인 호송대의 담당표 | 7일 | TFRKC_xfocus_RAIL_start | 없음 | 없음 | 60 | army_experience = 8 |
| TFRKC_xfocus_RAIL_military_2 / 호송 관제실 | 14일 | TFRKC_xfocus_RAIL_military_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_RAIL_idea_escorts army_experience = 5 |
| TFRKC_xfocus_RAIL_military_3 / 끊어진 구간의 훈련 | 21일 | TFRKC_xfocus_RAIL_military_2 | 없음 | 없음 | 14 | add_command_power = 10 |
| TFRKC_xfocus_RAIL_system_1 / 통행권의 가격 | 14일 | TFRKC_xfocus_RAIL_start | 없음 | 없음 | 14 | add_political_power = 20 |
| TFRKC_xfocus_RAIL_system_2 / 선로가 있어야 갈 수 있다 | 14일 | TFRKC_xfocus_RAIL_system_1 | 없음 | 없음 | 14 | add_political_power = 25 |
| TFRKC_xfocus_RAIL_system_3 / 다음 역이 사라지면 | 21일 | TFRKC_xfocus_RAIL_system_2 | 없음 | 없음 | 14 | army_experience = 8 add_political_power = 10 |
| TFRKC_xfocus_RAIL_council / 시간표의 주인은 누구인가 | 14일 | TFRKC_xfocus_RAIL_start | 없음 | 없음 | 14 | add_political_power = 15 |
| TFRKC_xfocus_RAIL_route_a / 중립 교통연방 | 21일 | TFRKC_xfocus_RAIL_council | 없음 | TFRKC_xfocus_RAIL_route_b | 20 | add_ideas = TFRKC_xfocus_RAIL_idea_neutral |
| TFRKC_xfocus_RAIL_route_b / 철도 군벌의 지휘봉 | 21일 | TFRKC_xfocus_RAIL_council | 없음 | TFRKC_xfocus_RAIL_route_a | 8 | add_ideas = TFRKC_xfocus_RAIL_idea_warlord |
| TFRKC_xfocus_RAIL_route_a_2 / 같은 운임, 같은 권리 | 14일 | TFRKC_xfocus_RAIL_route_a | 없음 | 없음 | 14 | add_stability = 0.03 add_political_power = 15 |
| TFRKC_xfocus_RAIL_route_b_2 / 명령으로 바뀐 신호 | 14일 | TFRKC_xfocus_RAIL_route_b | 없음 | 없음 | 14 | add_command_power = 10 add_stability = -0.02 |
| TFRKC_xfocus_RAIL_route_a_3 / 연방의 환승 협정 | 21일 | TFRKC_xfocus_RAIL_route_a_2 | 없음 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |
| TFRKC_xfocus_RAIL_route_b_3 / 도시를 멈출 권력 | 21일 | TFRKC_xfocus_RAIL_route_b_2 | 없음 | 없음 | 14 | army_experience = 8 add_political_power = 15 |
| TFRKC_xfocus_RAIL_settlement / 첫차가 다시 다니는 나라 | 21일 | TFRKC_xfocus_RAIL_civic_3, TFRKC_xfocus_RAIL_military_3, TFRKC_xfocus_RAIL_system_3 | TFRKC_xfocus_RAIL_route_a_3 또는 TFRKC_xfocus_RAIL_route_b_3 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |

### 백야국가보안국 — TFRKC_xfocus_WHITE_NIGHT_tree

| ID / 제목 | 기간 | 선행 AND | 선행 OR | 배타 | AI | 기본 보상 |
|---|---:|---|---|---|---:|---|
| TFRKC_xfocus_WHITE_NIGHT_start / 이름 없는 수신처 | 7일 | 없음 | 없음 | 없음 | 100 | add_political_power = 25 |
| TFRKC_xfocus_WHITE_NIGHT_civic_1 / 문서의 다른 사본 | 7일 | TFRKC_xfocus_WHITE_NIGHT_start | 없음 | 없음 | 32 | add_political_power = 20 |
| TFRKC_xfocus_WHITE_NIGHT_civic_2 / 닫힌 보관실 | 14일 | TFRKC_xfocus_WHITE_NIGHT_civic_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_WHITE_NIGHT_idea_system |
| TFRKC_xfocus_WHITE_NIGHT_civic_3 / 기밀이 아닌 생활 | 21일 | TFRKC_xfocus_WHITE_NIGHT_civic_2 | 없음 | 없음 | 14 | add_stability = 0.02 add_political_power = 15 |
| TFRKC_xfocus_WHITE_NIGHT_military_1 / 현장에 닿는 보고 | 7일 | TFRKC_xfocus_WHITE_NIGHT_start | 없음 | 없음 | 60 | army_experience = 8 |
| TFRKC_xfocus_WHITE_NIGHT_military_2 / 연락관의 책임 | 14일 | TFRKC_xfocus_WHITE_NIGHT_military_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_WHITE_NIGHT_idea_field_liaison army_experience = 5 |
| TFRKC_xfocus_WHITE_NIGHT_military_3 / 보고서를 믿기 전에 | 21일 | TFRKC_xfocus_WHITE_NIGHT_military_2 | 없음 | 없음 | 14 | add_command_power = 10 |
| TFRKC_xfocus_WHITE_NIGHT_system_1 / 명부 밖의 동의 | 14일 | TFRKC_xfocus_WHITE_NIGHT_start | 없음 | 없음 | 14 | add_political_power = 20 |
| TFRKC_xfocus_WHITE_NIGHT_system_2 / 장군은 문서가 아니다 | 14일 | TFRKC_xfocus_WHITE_NIGHT_system_1 | 없음 | 없음 | 14 | army_experience = 8 add_political_power = 10 |
| TFRKC_xfocus_WHITE_NIGHT_system_3 / 우리 안의 다른 수신처 | 21일 | TFRKC_xfocus_WHITE_NIGHT_system_2 | 없음 | 없음 | 14 | add_political_power = 25 |
| TFRKC_xfocus_WHITE_NIGHT_council / 누구에게 보고하는가 | 14일 | TFRKC_xfocus_WHITE_NIGHT_start | 없음 | 없음 | 14 | add_political_power = 15 |
| TFRKC_xfocus_WHITE_NIGHT_route_a / 기밀에도 주인이 있다 | 21일 | TFRKC_xfocus_WHITE_NIGHT_council | 없음 | TFRKC_xfocus_WHITE_NIGHT_route_b | 20 | add_ideas = TFRKC_xfocus_WHITE_NIGHT_idea_return |
| TFRKC_xfocus_WHITE_NIGHT_route_b / 보이지 않는 국가 | 21일 | TFRKC_xfocus_WHITE_NIGHT_council | 없음 | TFRKC_xfocus_WHITE_NIGHT_route_a | 8 | add_ideas = TFRKC_xfocus_WHITE_NIGHT_idea_shadow |
| TFRKC_xfocus_WHITE_NIGHT_route_a_2 / 감사받는 보관실 | 14일 | TFRKC_xfocus_WHITE_NIGHT_route_a | 없음 | 없음 | 14 | add_stability = 0.03 add_political_power = 15 |
| TFRKC_xfocus_WHITE_NIGHT_route_b_2 / 누락된 결재자의 이름 | 14일 | TFRKC_xfocus_WHITE_NIGHT_route_b | 없음 | 없음 | 14 | add_political_power = 30 add_stability = -0.02 |
| TFRKC_xfocus_WHITE_NIGHT_route_a_3 / 문을 닫는 조직 | 21일 | TFRKC_xfocus_WHITE_NIGHT_route_a_2 | 없음 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |
| TFRKC_xfocus_WHITE_NIGHT_route_b_3 / 아무도 끝내지 않은 임무 | 21일 | TFRKC_xfocus_WHITE_NIGHT_route_b_2 | 없음 | 없음 | 14 | add_command_power = 8 add_political_power = 15 |
| TFRKC_xfocus_WHITE_NIGHT_settlement / 남겨진 서명란 | 21일 | TFRKC_xfocus_WHITE_NIGHT_civic_3, TFRKC_xfocus_WHITE_NIGHT_military_3, TFRKC_xfocus_WHITE_NIGHT_system_3 | TFRKC_xfocus_WHITE_NIGHT_route_a_3 또는 TFRKC_xfocus_WHITE_NIGHT_route_b_3 | 없음 | 14 | add_political_power = 25 add_stability = 0.01 |

### 청송자유군 — TFRKC_xfocus_CHEONGSONG_tree

| ID / 제목 | 기간 | 선행 AND | 선행 OR | 배타 | AI | 기본 보상 |
|---|---:|---|---|---|---:|---|
| TFRKC_xfocus_CHEONGSONG_start / 같은 문을 나서다 | 7일 | 없음 | 없음 | 없음 | 100 | add_political_power = 25 |
| TFRKC_xfocus_CHEONGSONG_civic_1 / 명부의 다른 사정 | 7일 | TFRKC_xfocus_CHEONGSONG_start | 없음 | 없음 | 32 | add_stability = 0.03 |
| TFRKC_xfocus_CHEONGSONG_civic_2 / 서로 서명한 협약 | 14일 | TFRKC_xfocus_CHEONGSONG_civic_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_CHEONGSONG_idea_system |
| TFRKC_xfocus_CHEONGSONG_civic_3 / 문밖의 진료소 | 21일 | TFRKC_xfocus_CHEONGSONG_civic_2 | 없음 | 없음 | 14 | add_stability = 0.03 add_political_power = 15 |
| TFRKC_xfocus_CHEONGSONG_military_1 / 경험이 다른 사람들 | 7일 | TFRKC_xfocus_CHEONGSONG_start | 없음 | 없음 | 60 | army_experience = 8 |
| TFRKC_xfocus_CHEONGSONG_military_2 / 혼성부대의 규정 | 14일 | TFRKC_xfocus_CHEONGSONG_military_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_CHEONGSONG_idea_mixed_command army_experience = 5 |
| TFRKC_xfocus_CHEONGSONG_military_3 / 명령과 모욕 사이 | 21일 | TFRKC_xfocus_CHEONGSONG_military_2 | 없음 | 없음 | 14 | add_command_power = 10 |
| TFRKC_xfocus_CHEONGSONG_system_1 / 공로를 적는 장부 | 14일 | TFRKC_xfocus_CHEONGSONG_start | 없음 | 없음 | 14 | add_political_power = 20 |
| TFRKC_xfocus_CHEONGSONG_system_2 / 빈 약속을 막으려면 | 14일 | TFRKC_xfocus_CHEONGSONG_system_1 | 없음 | 없음 | 14 | add_political_power = 25 |
| TFRKC_xfocus_CHEONGSONG_system_3 / 누가 형량을 계산하는가 | 21일 | TFRKC_xfocus_CHEONGSONG_system_2 | 없음 | 없음 | 14 | add_stability = 0.02 add_political_power = 15 |
| TFRKC_xfocus_CHEONGSONG_council / 자유라는 이름의 날짜 | 14일 | TFRKC_xfocus_CHEONGSONG_start | 없음 | 없음 | 14 | add_political_power = 15 |
| TFRKC_xfocus_CHEONGSONG_route_a / 약속한 사면을 지키다 | 21일 | TFRKC_xfocus_CHEONGSONG_council | 없음 | TFRKC_xfocus_CHEONGSONG_route_b | 20 | add_ideas = TFRKC_xfocus_CHEONGSONG_idea_amnesty |
| TFRKC_xfocus_CHEONGSONG_route_b / 지휘부가 쥔 달력 | 21일 | TFRKC_xfocus_CHEONGSONG_council | 없음 | TFRKC_xfocus_CHEONGSONG_route_a | 8 | add_ideas = TFRKC_xfocus_CHEONGSONG_idea_sentences |
| TFRKC_xfocus_CHEONGSONG_route_a_2 / 공로의 공개 심사 | 14일 | TFRKC_xfocus_CHEONGSONG_route_a | 없음 | 없음 | 14 | add_stability = 0.03 add_political_power = 15 |
| TFRKC_xfocus_CHEONGSONG_route_b_2 / 다시 늘어난 조건 | 14일 | TFRKC_xfocus_CHEONGSONG_route_b | 없음 | 없음 | 14 | add_war_support = 0.02 add_stability = -0.03 |
| TFRKC_xfocus_CHEONGSONG_route_a_3 / 전후에도 효력 있는 서명 | 21일 | TFRKC_xfocus_CHEONGSONG_route_a_2 | 없음 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |
| TFRKC_xfocus_CHEONGSONG_route_b_3 / 끝나지 않는 복무 | 21일 | TFRKC_xfocus_CHEONGSONG_route_b_2 | 없음 | 없음 | 14 | army_experience = 8 add_political_power = 15 |
| TFRKC_xfocus_CHEONGSONG_settlement / 문밖에서 남길 기록 | 21일 | TFRKC_xfocus_CHEONGSONG_civic_3, TFRKC_xfocus_CHEONGSONG_military_3, TFRKC_xfocus_CHEONGSONG_system_3 | TFRKC_xfocus_CHEONGSONG_route_a_3 또는 TFRKC_xfocus_CHEONGSONG_route_b_3 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |

### 대한황실봉대회 — TFRKC_xfocus_IMPERIAL_tree

| ID / 제목 | 기간 | 선행 AND | 선행 OR | 배타 | AI | 기본 보상 |
|---|---:|---|---|---|---:|---|
| TFRKC_xfocus_IMPERIAL_start / 임시 왕좌의 천 | 7일 | 없음 | 없음 | 없음 | 100 | add_political_power = 25 |
| TFRKC_xfocus_IMPERIAL_civic_1 / 의전보다 먼저 배급 | 7일 | TFRKC_xfocus_IMPERIAL_start | 없음 | 없음 | 32 | add_stability = 0.03 |
| TFRKC_xfocus_IMPERIAL_civic_2 / 왕관을 위한 회계 | 14일 | TFRKC_xfocus_IMPERIAL_civic_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_IMPERIAL_idea_system |
| TFRKC_xfocus_IMPERIAL_civic_3 / 충성의 민원 창구 | 21일 | TFRKC_xfocus_IMPERIAL_civic_2 | 없음 | 없음 | 14 | add_stability = 0.02 add_political_power = 20 |
| TFRKC_xfocus_IMPERIAL_military_1 / 왕좌 곁의 성인 방위대 | 7일 | TFRKC_xfocus_IMPERIAL_start | 없음 | 없음 | 60 | army_experience = 8 |
| TFRKC_xfocus_IMPERIAL_military_2 / 궁정 밖의 훈련장 | 14일 | TFRKC_xfocus_IMPERIAL_military_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_IMPERIAL_idea_retinue army_experience = 5 |
| TFRKC_xfocus_IMPERIAL_military_3 / 귀순의 실제 명부 | 21일 | TFRKC_xfocus_IMPERIAL_military_2 | 없음 | 없음 | 14 | army_experience = 12 |
| TFRKC_xfocus_IMPERIAL_system_1 / 계보를 보관하는 방 | 14일 | TFRKC_xfocus_IMPERIAL_start | 없음 | 없음 | 14 | add_political_power = 20 |
| TFRKC_xfocus_IMPERIAL_system_2 / 왕관의 서류 심사 | 14일 | TFRKC_xfocus_IMPERIAL_system_1 | 없음 | 없음 | 14 | add_stability = 0.02 add_political_power = 15 |
| TFRKC_xfocus_IMPERIAL_system_3 / 문을 두드리는 지방 | 21일 | TFRKC_xfocus_IMPERIAL_system_2 | 없음 | 없음 | 14 | add_political_power = 25 |
| TFRKC_xfocus_IMPERIAL_council / 왕관 아래의 세 길 | 14일 | TFRKC_xfocus_IMPERIAL_start | 없음 | 없음 | 14 | add_political_power = 15 |
| TFRKC_xfocus_IMPERIAL_route_a / 입헌군주국의 약속 | 21일 | TFRKC_xfocus_IMPERIAL_council | 없음 | TFRKC_xfocus_IMPERIAL_route_b, TFRKC_xfocus_IMPERIAL_route_c | 20 | add_ideas = TFRKC_xfocus_IMPERIAL_idea_constitutional |
| TFRKC_xfocus_IMPERIAL_route_b / 황제의 직접 결재 | 21일 | TFRKC_xfocus_IMPERIAL_council | 없음 | TFRKC_xfocus_IMPERIAL_route_a, TFRKC_xfocus_IMPERIAL_route_c | 8 | add_ideas = TFRKC_xfocus_IMPERIAL_idea_personal |
| TFRKC_xfocus_IMPERIAL_route_a_2 / 의회가 여는 궁정 | 14일 | TFRKC_xfocus_IMPERIAL_route_a | 없음 | 없음 | 14 | add_stability = 0.03 add_political_power = 15 |
| TFRKC_xfocus_IMPERIAL_route_b_2 / 칙령의 접수처 | 14일 | TFRKC_xfocus_IMPERIAL_route_b | 없음 | 없음 | 14 | add_political_power = 30 add_stability = -0.02 |
| TFRKC_xfocus_IMPERIAL_route_a_3 / 혈통보다 먼저 헌법 | 21일 | TFRKC_xfocus_IMPERIAL_route_a_2 | 없음 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |
| TFRKC_xfocus_IMPERIAL_route_b_3 / 왕관이 답해야 할 것 | 21일 | TFRKC_xfocus_IMPERIAL_route_b_2 | 없음 | 없음 | 14 | add_command_power = 8 add_political_power = 15 |
| TFRKC_xfocus_IMPERIAL_settlement / 왕관 뒤의 나라 | 21일 | TFRKC_xfocus_IMPERIAL_civic_3, TFRKC_xfocus_IMPERIAL_military_3, TFRKC_xfocus_IMPERIAL_system_3 | TFRKC_xfocus_IMPERIAL_route_a_3 또는 TFRKC_xfocus_IMPERIAL_route_b_3 또는 TFRKC_xfocus_IMPERIAL_route_c_3 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |
| TFRKC_xfocus_IMPERIAL_route_c / 백제의 이름을 잇다 | 21일 | TFRKC_xfocus_IMPERIAL_council | 없음 | TFRKC_xfocus_IMPERIAL_route_a, TFRKC_xfocus_IMPERIAL_route_b | 12 | add_ideas = TFRKC_xfocus_IMPERIAL_idea_baekje |
| TFRKC_xfocus_IMPERIAL_route_c_2 / 옛 도읍의 새 주민 | 14일 | TFRKC_xfocus_IMPERIAL_route_c | 없음 | 없음 | 14 | add_stability = 0.03 add_political_power = 15 |
| TFRKC_xfocus_IMPERIAL_route_c_3 / 계보가 아닌 공동체 | 21일 | TFRKC_xfocus_IMPERIAL_route_c_2 | 없음 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |

### 서울지하자치구 — TFRKC_xfocus_UNDERGROUND_tree

| ID / 제목 | 기간 | 선행 AND | 선행 OR | 배타 | AI | 기본 보상 |
|---|---:|---|---|---|---:|---|
| TFRKC_xfocus_UNDERGROUND_start / 막차 뒤의 역장회의 | 7일 | 없음 | 없음 | 없음 | 100 | add_political_power = 20 |
| TFRKC_xfocus_UNDERGROUND_civic_1 / 플랫폼의 잠자리 | 7일 | TFRKC_xfocus_UNDERGROUND_start | 없음 | 없음 | 32 | add_stability = 0.03 |
| TFRKC_xfocus_UNDERGROUND_civic_2 / 역무실의 생활망 | 14일 | TFRKC_xfocus_UNDERGROUND_civic_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_UNDERGROUND_idea_system |
| TFRKC_xfocus_UNDERGROUND_civic_3 / 역 이름으로 부르는 사람 | 21일 | TFRKC_xfocus_UNDERGROUND_civic_2 | 없음 | 없음 | 14 | add_stability = 0.03 add_political_power = 15 |
| TFRKC_xfocus_UNDERGROUND_military_1 / 성인 경비조의 구역 | 7일 | TFRKC_xfocus_UNDERGROUND_start | 없음 | 없음 | 60 | army_experience = 8 |
| TFRKC_xfocus_UNDERGROUND_military_2 / 서로 들리는 무전 | 14일 | TFRKC_xfocus_UNDERGROUND_military_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_UNDERGROUND_idea_wardens army_experience = 5 |
| TFRKC_xfocus_UNDERGROUND_military_3 / 출입구의 책임 | 21일 | TFRKC_xfocus_UNDERGROUND_military_2 | 없음 | 없음 | 14 | add_command_power = 10 |
| TFRKC_xfocus_UNDERGROUND_system_1 / 지상에 보내는 편지 | 14일 | TFRKC_xfocus_UNDERGROUND_start | 없음 | 없음 | 14 | add_political_power = 20 |
| TFRKC_xfocus_UNDERGROUND_system_2 / 지도에 겹치지 않는 자치 | 14일 | TFRKC_xfocus_UNDERGROUND_system_1 | 없음 | 없음 | 14 | add_political_power = 25 |
| TFRKC_xfocus_UNDERGROUND_system_3 / 문을 열기 전의 조건 | 21일 | TFRKC_xfocus_UNDERGROUND_system_2 | 없음 | 없음 | 14 | army_experience = 8 add_political_power = 10 |
| TFRKC_xfocus_UNDERGROUND_council / 계단 위로 이어지는 길 | 14일 | TFRKC_xfocus_UNDERGROUND_start | 없음 | 없음 | 14 | add_political_power = 15 |
| TFRKC_xfocus_UNDERGROUND_route_a / 서로 다른 층의 협약 | 21일 | TFRKC_xfocus_UNDERGROUND_council | 없음 | TFRKC_xfocus_UNDERGROUND_route_b | 20 | add_ideas = TFRKC_xfocus_UNDERGROUND_idea_autonomy |
| TFRKC_xfocus_UNDERGROUND_route_b / 계단 위로 | 21일 | TFRKC_xfocus_UNDERGROUND_council | 없음 | TFRKC_xfocus_UNDERGROUND_route_a | 8 | add_ideas = TFRKC_xfocus_UNDERGROUND_idea_surface |
| TFRKC_xfocus_UNDERGROUND_route_a_2 / 열린 출입구의 규칙 | 14일 | TFRKC_xfocus_UNDERGROUND_route_a | 없음 | 없음 | 14 | add_stability = 0.03 add_political_power = 15 |
| TFRKC_xfocus_UNDERGROUND_route_b_2 / 지상에서의 주소 | 14일 | TFRKC_xfocus_UNDERGROUND_route_b | 없음 | 없음 | 14 | army_experience = 8 add_political_power = 10 |
| TFRKC_xfocus_UNDERGROUND_route_a_3 / 역장회의의 자치헌장 | 21일 | TFRKC_xfocus_UNDERGROUND_route_a_2 | 없음 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |
| TFRKC_xfocus_UNDERGROUND_route_b_3 / 빛 아래의 책임 | 21일 | TFRKC_xfocus_UNDERGROUND_route_b_2 | 없음 | 없음 | 14 | add_political_power = 20 add_stability = 0.02 |
| TFRKC_xfocus_UNDERGROUND_settlement / 다음 열차를 기다리는 사람 | 21일 | TFRKC_xfocus_UNDERGROUND_civic_3, TFRKC_xfocus_UNDERGROUND_military_3, TFRKC_xfocus_UNDERGROUND_system_3 | TFRKC_xfocus_UNDERGROUND_route_a_3 또는 TFRKC_xfocus_UNDERGROUND_route_b_3 | 없음 | 14 | add_political_power = 20 add_stability = 0.02 |

### 망향군 — TFRKC_xfocus_HOMECOMING_tree

| ID / 제목 | 기간 | 선행 AND | 선행 OR | 배타 | AI | 기본 보상 |
|---|---:|---|---|---|---:|---|
| TFRKC_xfocus_HOMECOMING_start / 돌아와도 끝나지 않은 전쟁 | 7일 | 없음 | 없음 | 없음 | 100 | add_political_power = 20 army_experience = 5 |
| TFRKC_xfocus_HOMECOMING_civic_1 / 귀환자의 진료 기록 | 7일 | TFRKC_xfocus_HOMECOMING_start | 없음 | 없음 | 32 | add_stability = 0.03 |
| TFRKC_xfocus_HOMECOMING_civic_2 / 돌아온 사람의 명부 | 14일 | TFRKC_xfocus_HOMECOMING_civic_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_HOMECOMING_idea_system |
| TFRKC_xfocus_HOMECOMING_civic_3 / 이름을 다시 부르는 일 | 21일 | TFRKC_xfocus_HOMECOMING_civic_2 | 없음 | 없음 | 14 | add_stability = 0.03 add_political_power = 15 |
| TFRKC_xfocus_HOMECOMING_military_1 / 숙련된 소부대 | 7일 | TFRKC_xfocus_HOMECOMING_start | 없음 | 없음 | 60 | army_experience = 10 |
| TFRKC_xfocus_HOMECOMING_military_2 / 같은 전장을 기억하다 | 14일 | TFRKC_xfocus_HOMECOMING_military_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_HOMECOMING_idea_veterans army_experience = 5 |
| TFRKC_xfocus_HOMECOMING_military_3 / 낡은 장비의 새 점검 | 21일 | TFRKC_xfocus_HOMECOMING_military_2 | 없음 | 없음 | 14 | army_experience = 12 |
| TFRKC_xfocus_HOMECOMING_system_1 / 반중 동맹의 회의 | 14일 | TFRKC_xfocus_HOMECOMING_start | 없음 | 없음 | 14 | add_political_power = 20 |
| TFRKC_xfocus_HOMECOMING_system_2 / 평화를 요구하는 편지 | 14일 | TFRKC_xfocus_HOMECOMING_system_1 | 없음 | 없음 | 14 | add_stability = 0.02 add_political_power = 15 |
| TFRKC_xfocus_HOMECOMING_system_3 / 복무 뒤의 생활비 | 21일 | TFRKC_xfocus_HOMECOMING_system_2 | 없음 | 없음 | 14 | add_political_power = 25 |
| TFRKC_xfocus_HOMECOMING_council / 어느 전쟁에서 돌아오는가 | 14일 | TFRKC_xfocus_HOMECOMING_start | 없음 | 없음 | 14 | add_political_power = 15 |
| TFRKC_xfocus_HOMECOMING_route_a / 전후의 주소 | 21일 | TFRKC_xfocus_HOMECOMING_council | 없음 | TFRKC_xfocus_HOMECOMING_route_b | 20 | add_ideas = TFRKC_xfocus_HOMECOMING_idea_home |
| TFRKC_xfocus_HOMECOMING_route_b / 중국을 향한 다음 지도 | 21일 | TFRKC_xfocus_HOMECOMING_council | 없음 | TFRKC_xfocus_HOMECOMING_route_a | 8 | add_ideas = TFRKC_xfocus_HOMECOMING_idea_revenge |
| TFRKC_xfocus_HOMECOMING_route_a_2 / 복귀를 도울 사람들 | 14일 | TFRKC_xfocus_HOMECOMING_route_a | 없음 | 없음 | 14 | add_stability = 0.03 add_political_power = 15 |
| TFRKC_xfocus_HOMECOMING_route_b_2 / 복수의 비용표 | 14일 | TFRKC_xfocus_HOMECOMING_route_b | 없음 | 없음 | 14 | army_experience = 10 add_stability = -0.02 |
| TFRKC_xfocus_HOMECOMING_route_a_3 / 강화를 받아들일 용기 | 21일 | TFRKC_xfocus_HOMECOMING_route_a_2 | 없음 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |
| TFRKC_xfocus_HOMECOMING_route_b_3 / 동맹이 멈추려 할 때 | 21일 | TFRKC_xfocus_HOMECOMING_route_b_2 | 없음 | 없음 | 14 | add_command_power = 8 add_political_power = 15 |
| TFRKC_xfocus_HOMECOMING_settlement / 돌아오지 못한 이름들 | 21일 | TFRKC_xfocus_HOMECOMING_civic_3, TFRKC_xfocus_HOMECOMING_military_3, TFRKC_xfocus_HOMECOMING_system_3 | TFRKC_xfocus_HOMECOMING_route_a_3 또는 TFRKC_xfocus_HOMECOMING_route_b_3 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |

### 국가채권회수단 — TFRKC_xfocus_CREDIT_tree

| ID / 제목 | 기간 | 선행 AND | 선행 OR | 배타 | AI | 기본 보상 |
|---|---:|---|---|---|---:|---|
| TFRKC_xfocus_CREDIT_start / 항구로 온 청구서 | 7일 | 없음 | 없음 | 없음 | 100 | add_political_power = 30 |
| TFRKC_xfocus_CREDIT_civic_1 / 같은 빚을 두 번 세지 않게 | 7일 | TFRKC_xfocus_CREDIT_start | 없음 | 없음 | 32 | add_political_power = 20 |
| TFRKC_xfocus_CREDIT_civic_2 / 서로 맞춘 장부 | 14일 | TFRKC_xfocus_CREDIT_civic_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_CREDIT_idea_system |
| TFRKC_xfocus_CREDIT_civic_3 / 청구서 아래의 민원 | 21일 | TFRKC_xfocus_CREDIT_civic_2 | 없음 | 없음 | 14 | add_stability = 0.03 add_political_power = 15 |
| TFRKC_xfocus_CREDIT_military_1 / 경비 계약의 담당표 | 7일 | TFRKC_xfocus_CREDIT_start | 없음 | 없음 | 60 | army_experience = 8 |
| TFRKC_xfocus_CREDIT_military_2 / 담보 경비의 지휘 | 14일 | TFRKC_xfocus_CREDIT_military_1 | 없음 | 없음 | 14 | add_ideas = TFRKC_xfocus_CREDIT_idea_contract_guards army_experience = 5 |
| TFRKC_xfocus_CREDIT_military_3 / 지켜야 할 사람의 목록 | 21일 | TFRKC_xfocus_CREDIT_military_2 | 없음 | 없음 | 14 | add_command_power = 10 |
| TFRKC_xfocus_CREDIT_system_1 / 전쟁에도 만기가 있다 | 14일 | TFRKC_xfocus_CREDIT_start | 없음 | 없음 | 14 | add_political_power = 20 |
| TFRKC_xfocus_CREDIT_system_2 / 돈을 빌려줄 조건 | 14일 | TFRKC_xfocus_CREDIT_system_1 | 없음 | 없음 | 14 | add_political_power = 25 |
| TFRKC_xfocus_CREDIT_system_3 / 연체된 국가의 주소 | 21일 | TFRKC_xfocus_CREDIT_system_2 | 없음 | 없음 | 14 | add_political_power = 15 add_stability = 0.02 |
| TFRKC_xfocus_CREDIT_council / 빚을 갚을 수 있는 나라 | 14일 | TFRKC_xfocus_CREDIT_start | 없음 | 없음 | 14 | add_political_power = 15 |
| TFRKC_xfocus_CREDIT_route_a / 채무를 다시 적다 | 21일 | TFRKC_xfocus_CREDIT_council | 없음 | TFRKC_xfocus_CREDIT_route_b | 20 | add_ideas = TFRKC_xfocus_CREDIT_idea_restructure |
| TFRKC_xfocus_CREDIT_route_b / 담보국가의 장부 | 21일 | TFRKC_xfocus_CREDIT_council | 없음 | TFRKC_xfocus_CREDIT_route_a | 8 | add_ideas = TFRKC_xfocus_CREDIT_idea_collateral |
| TFRKC_xfocus_CREDIT_route_a_2 / 회복을 기다리는 만기 | 14일 | TFRKC_xfocus_CREDIT_route_a | 없음 | 없음 | 14 | add_stability = 0.03 add_political_power = 15 |
| TFRKC_xfocus_CREDIT_route_b_2 / 모든 창구가 회수부로 | 14일 | TFRKC_xfocus_CREDIT_route_b | 없음 | 없음 | 14 | add_political_power = 30 add_stability = -0.02 |
| TFRKC_xfocus_CREDIT_route_a_3 / 갚을 수 있는 약정 | 21일 | TFRKC_xfocus_CREDIT_route_a_2 | 없음 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |
| TFRKC_xfocus_CREDIT_route_b_3 / 국가보다 먼저 담보 | 21일 | TFRKC_xfocus_CREDIT_route_b_2 | 없음 | 없음 | 14 | army_experience = 8 add_political_power = 15 |
| TFRKC_xfocus_CREDIT_settlement / 장부 밖의 나라 | 21일 | TFRKC_xfocus_CREDIT_civic_3, TFRKC_xfocus_CREDIT_military_3, TFRKC_xfocus_CREDIT_system_3 | TFRKC_xfocus_CREDIT_route_a_3 또는 TFRKC_xfocus_CREDIT_route_b_3 | 없음 | 14 | add_political_power = 25 add_stability = 0.02 |

## 검증 결과와 다음 연결

정적/간이 로직 시뮬레이션18검사를 통과했습니다. 실제 엔진 테스트와 구분합니다.

- 16 trees, 291 focus definitions and 65 ideas parse; installed and src files agree — PASS
- Previous focus package is preserved; concurrent map/event/war work is not overwritten — PASS
- No effective authored tree/focus/idea/effect/trigger ID collisions — PASS
- All prerequisite references exist in the same tree; dependency graph is acyclic — PASS
- Every political route reaches settlement without requiring a mutually exclusive route — PASS
- No focus center overlaps or prerequisite edges crossing other focus icons — PASS
- Policy commitment locks opposite routes and opposite policy ideas never stack — PASS
- Duplicate completion or valid organization-state bypass cannot replay political power or experience rewards — PASS
- Late entry and post-war domestic progress have no date or global-opening deadline — PASS
- Annexed, capitulated or fully displaced actors receive no completion rewards — PASS
- Wartime-only ideas activate only for actual participants and are removed after the campaign — PASS
- Actual deployed tags bind only their intended country; underground cannot bind to its host — PASS
- No direct war/territory/factory/manpower spawning or unresolved event/effect calls — PASS
- Native rewards and idea modifiers exist in installed HOI4 documentation — PASS
- All focus titles/descriptions, idea text and tooltips have unique BOM Korean localisation and balanced colours — PASS
- Actual load-order graphics match the original TFRKP textures — PASS
- System requests expose real ready triggers; organization policies are KEY-scoped and cannot give host-wide ideas — PASS
- AI starts with short independent recovery and has nonzero weights for all reachable alternatives — PASS

정치 경로33개(일반15세력×2 + 황실3)의 최종 운영안 도달을 모두 검사했습니다. 서울지하 경로는 실제 국가 할당 검증이 아니라 조직용 설계 검증입니다. 15 TAG의 올바른 할당, 잘못된 호스트 할당 거부, 늦은 등장/전후 진행, 반대 정책의 중복 차단, 재완료 중복 보상 방지, 종료 시 전시 효과 제거를 시뮬레이션했습니다. 모든 새 참조와 원본 그림을 검사했습니다. 기존 파서가 읽지 못한 의존성 파일은 validation-xfocus.json에 별도로 기록했으며 신규 접두사가 없음을 확인했습니다.

사용자의 범위 축소 지시에 따라 게임 실행·중점 화면·AI 실전·저장/불러오기는 미검증으로 남깁니다. 기본 구현을 완료하기 위한 추가 사용자 정보는 없습니다. 후속 연결에 필요한 최소 정보는 이벤트 담당의 조직 활성/디시전 ID, 전쟁 담당의 실제 독립·통합·거래 효과 ID와 호출 조건입니다. 해당 기능을 받기 전에는 고유 시스템을 이미 완성했다고 안내하지 않습니다.
