// 이 코드는 input과 initLabel 두 변수를 정의합니다.
// input은 ID가 "input"인 입력 요소에 대한 참조입니다.
// initLabel은 ID가 "label"인 레이블 요소에 대한 참조입니다.

/*화면이 열리면 실행됨*/
window.onload = function() {
    var input = document.getElementById("input");
    var initLabel = document.getElementById("label");

    input.addEventListener("change", (event) => {
        const files = changeEvent(event);
        handleUpdate(files);
    });

    initLabel.addEventListener("mouseover", (event) => {
        event.preventDefault();
        const label = document.getElementById("label");
        label?.classList.add("label--hover");
    });

    initLabel.addEventListener("mouseout", (event) => {
        event.preventDefault();
        const label = document.getElementById("label");
        label?.classList.remove("label--hover");
    });

    document.addEventListener("dragenter", (event) => {
        event.preventDefault();
        console.log("dragenter");
        if (event.target.className === "inner") {
            event.target.style.background = "#616161";
        }
    });

    document.addEventListener("dragover", (event) => {
        console.log("dragover");
        event.preventDefault();
    });

    document.addEventListener("dragleave", (event) => {
        event.preventDefault();
        console.log("dragleave");
        if (event.target.className === "inner") {
            event.target.style.background = "#3a3a3a";
        }
    });

    document.addEventListener("drop", (event) => {
        event.preventDefault();
        console.log("drop");
        if (event.target.className === "inner") {
            const files = event.dataTransfer?.files;
            event.target.style.background = "#3a3a3a";
            handleUpdate([...files]);
        }
    });

};

function changeEvent(event){
    const { target } = event;
    return [...target.files];
};

function handleUpdate(fileList) {
    // 이 함수는 파일 목록을 받아 이미지를 미리보기 영역에 추가합니다.
    // debugger
    const preview = document.getElementById("preview");

    // 파일 목록을 순회합니다.
    fileList.forEach((file) => {
        // 새로운 FileReader 객체를 생성합니다.
        const reader = new FileReader();


        // 파일이 읽어질 때마다 호출되는 이벤트 리스너를 등록합니다.
        reader.addEventListener("load", (event) => {
            // 이미지 요소를 생성합니다.
            const img = el("img", {
                className: "embed-img",
                src: event.target?.result,
            });

            // 이미지를 담을 div 요소를 생성합니다.
            const imgContainer = el("div", { className: "container-img" }, img);

            // 이미지를 제거하는 버튼을 생성합니다.
            const removeButton = el("button", {
                className: "remove-button",
                textContent: "제거",
            });

            // 제거 버튼에 이벤트를 추가합니다.
            removeButton.addEventListener("click", () => {
                // 프리뷰에서 이미지를 담은 div를 제거
                imgContainer.remove();

                // 내가 제거한 embed-img에 대응하는 file input에서 실제로 삭제
                const input = document.getElementById("input");
                /*이름이 일치하면 삭제함.*/
                const fileIndex = Array.from(input.files).findIndex((inputFile) => inputFile.name === file.name);
                if (fileIndex !== -1) {
                    /*파일을 삭제할 때마다 새로 files 배열 만들어*/
                    const newFiles = Array.from(input.files).slice(0, fileIndex);

                    /* splice() 메서드를 사용하여 특정 인덱스(fileIndex)에서 파일을 제거 */
                    newFiles.splice(fileIndex.files, 1);


                    /*'files' 속성을 사용하여 업데이트된 파일 배열을 파일 입력 필드에 다시 할당*/
                    input.files = newFiles;


                }
            });

            // 제거 버튼을 이미지 container div에 추가
            imgContainer.append(removeButton);

            // 미리보기 영역에 이미지를 추가
            preview.append(imgContainer);
            // debugger

        });

        // 파일을 읽어들입니다.
        reader.readAsDataURL(file);
        // debugger
    });
}
function el(nodeName, attributes, ...children) {
    // 지정된 이름과 속성을 가진 HTML 요소를 생성합니다.

    // 인수:
    //   nodeName: 생성할 HTML 요소의 이름입니다.
    //   attributes: 요소의 속성 사전입니다.
    //   children: 요소의 자식 요소 목록입니다.

    // 반환값:
    //   생성된 HTML 요소입니다.

    const node =
        nodeName === "fragment"
            ? document.createDocumentFragment()
            : document.createElement(nodeName);

    // 속성 사전을 반복하고 요소에 속성을 설정합니다.
    Object.entries(attributes).forEach(([key, value]) => {
        if (key === "events") {
            // 이벤트 사전을 반복하고 요소에 이벤트 리스너를 추가합니다.
            Object.entries(value).forEach(([type, listener]) => {
                node.addEventListener(type, listener);
            });
        } else if (key in node) {
            // 요소에 속성을 설정합니다.
            try {
                node[key] = value;
            } catch (err) {
                // 속성이 요소의 유효한 속성이 아닌 경우 HTML 속성으로 속성을 설정합니다.
                node.setAttribute(key, value);
            }
        } else {
            // HTML 속성으로 속성을 설정합니다.
            node.setAttribute(key, value);
        }
    });

    // 자식 요소 목록을 반복하고 요소에 자식 요소를 추가합니다.
    children.forEach((childNode) => {
        if (typeof childNode === "string") {
            // 자식 문자열에서 텍스트 노드를 생성하고 요소에 추가합니다.
            node.appendChild(document.createTextNode(childNode));
        } else {
            // 요소에 자식 요소를 추가합니다.
            node.appendChild(childNode);
        }
    });

    // 생성된 HTML 요소를 반환합니다.
    // debugger
    return node;
}
// // 이 코드는 input 요소의 change 이벤트에 대한 리스너를 등록합니다.
// // change 이벤트가 발생하면 changeEvent() 함수가 호출됩니다.
//
// // 이 함수는 사용자가 선택한 파일을 가져옵니다.
// function changeEvent(event) {
//     // event 객체의 target 속성은 이벤트를 트리거한 요소를 나타냅니다.
//     // 이 경우 target은 input 요소입니다.
//     // {target}으로 {}를 사용한 것은 Object Deconstruction.
//     // Object Deconstruction은 객체의 특정 속성을 변수에 할당하는 데 사용할 수 있는 JavaScript의 기능
//     const {target} = event;
//
//     // target 요소의 files 속성은 사용자가 선택한 파일을 나타냅니다.
//     // files 속성은 File 개체의 배열입니다.
//     return [...target.files];
// }
//
// // 이 코드는 initLabel 요소의 mouseover 이벤트에 대한 리스너를 등록합니다.
// // mouseover 이벤트가 발생하면 mouseover() 함수가 호출됩니다.
// // mouseover는 마우스가 요소 위에 올라갔을 때
// initLabel.addEventListener("mouseover", mouseover);
//
// // 이 함수는 initLabel 요소에 label--hover 클래스를 추가합니다
// function mouseover(event) {
//     // event 객체는 함수로 전달됩니다.
//     // event 객체의 preventDefault() 메서드는 기본 동작이 발생하지 않도록 합니다.
//     // 이 경우 기본 동작은 링크를 따라가는 것입니다.
//     event.preventDefault();
//     // document.getElementById() 메서드는 ID가 "label"인 요소를 가져옵니다.
//     const label = document.getElementById("label");
//
//     // label 요소의 classList 속성은 요소에 적용된 클래스의 목록을 나타냅니다.
//     // classList 속성의 add() 메서드는 label--hover 클래스를 목록에 추가합니다.
//     // label?은 선택적 프로퍼티입니다.
//     // 즉, label 요소가 존재하지 않을 수도 있습니다.
//     // 이 경우 classList.add()는 아무 작업 수행X.
//     label?.classList.add("label--hover");
// }
//
// // 이 코드는 initLabel 요소의 mouseout 이벤트에 대한 리스너를 등록합니다.
// // mouseout 이벤트가 발생하면 mouseout() 함수가 호출됩니다.
// initLabel.addEventListener("mouseout", mouseout);
//
// // 이 함수는 initLabel 요소에서 label--hover 클래스를 제거합니다.
// function mouseout(event) {
//     // event 객체는 함수로 전달됩니다.
//     // event 객체의 preventDefault() 메서드는 기본 동작이 발생하지 않도록 합니다.
//     // 이 경우 기본 동작은 링크를 따라가는 것입니다.
//     event.preventDefault();
//
//     // document.getElementById() 메서드는 ID가 "label"인 요소를 가져옵니다.
//     const label = document.getElementById("label");
//
//     // label 요소의 classList 속성은 요소에 적용된 클래스의 목록을 나타냅니다.
//     // classList 속성의 remove() 메서드는 label--hover 클래스를 목록에서 제거합니다.
//     label?.classList.remove("label--hover");
// }
//
// // 이 코드는 document의 dragenter 이벤트에 대한 리스너를 등록합니다.
// // dragenter 이벤트가 발생하면 dragenter() 함수가 호출됩니다.
// document.addEventListener("dragenter", dragenter);
//
// // 이 함수는 콘솔에 "dragenter" 메시지를 기록합니다.
// // 또한 이벤트의 대상이 "inner" 클래스를 가진 요소인지 확인합니다.
// // 그렇다면 요소의 배경색을 "#616161"로 설정합니다.
// // dragenter 이벤트는 드래그되는 요소가 다른 요소의 영역에 진입할 때 발생하는 이벤트
// function dragenter(event) {
// // event 객체는 함수로 전달됩니다.
//     console.log("dragenter");
//
//     // event 객체의 target 속성은 이벤트를 트리거한 요소를 나타냅니다.
//     const target = event.target;
//
//     // target 요소의 classList 속성은 요소에 적용된 클래스의 목록을 나타냅니다.
//     // classList 속성의 contains() 메서드는 목록에 클래스가 있는지 확인합니다.
//     if (target.classList.contains("inner")) {
//         target.style.background = "#616161";
//     }
// }
//
// // 이 코드는 document의 dragover 이벤트에 대한 리스너를 등록합니다.
// // dragover 이벤트가 발생하면 dragover() 함수가 호출됩니다.
// // dragover 이벤트는 드래그되는 요소가 다른 요소의 영역에 머무를 때 발생하는 이벤트
// document.addEventListener("dragover", dragover);
//
// // 이 함수는 콘솔에 "dragover" 메시지를 기록합니다.
// function dragover(event) {
//     // event 객체는 함수로 전달됩니다.
//     console.log("dragover");
// }
// // "dragleave" 이벤트를 위해 document에 이벤트 리스너를 추가합니다.
// document.addEventListener("dragleave", (event) => {
//     event.preventDefault();
//     console.log("dragleave");
//     if (event.target.className === "inner") {
//         event.target.style.background = "#3a3a3a";
//     }
// });
//
// // "drop" 이벤트를 위해 document에 이벤트 리스너를 추가합니다.
// document.addEventListener("drop", (event) => {
//     event.preventDefault();
//     console.log("drop");
//     if (event.target.className === "inner") {
//         const files = event.dataTransfer?.files;
//         // 이벤트 dataTransfer에서 파일들을 가져옵니다 (존재하는 경우)
//         event.target.style.background = "#3a3a3a";
//         handleUpdate([...files]); // 파일들을 매개변수로 하여 handleUpdate 함수를 호출합니다.
//     }
// });
//
// // "change" 이벤트를 처리하기 위한 함수입니다.
// function changeEvent(event) {
//     const { target } = event; // 이벤트에서 "target" 속성을 추출합니다.
//     return [...target.files]; // 대상 요소에서 파일들의 배열을 반환합니다.
// }
//
// // 업데이트를 처리하기 위한 함수입니다.
// function handleUpdate(fileList) {
//     // id가 "preview"인 요소를 가져옵니다.
//     const preview = document.getElementById("preview");
//
//     fileList.forEach((file) => {
//         // 새 FileReader 객체를 생성합니다.
//         const reader = new FileReader();
//         // "load" 이벤트에 대한 이벤트 리스너를 추가합니다.
//         reader.addEventListener("load", (event) => {
//             // 지정된 속성으로 img 요소를 생성합니다.
//             const img = el("img", {
//                 className: "embed-img",
//                 src: event.target?.result,
//             });
//             const imgContainer = el("div", { className: "container-img" }, img); // 지정된 속성과 img를 자식으로 가지는 div 요소를 생성합니다.
//             preview.append(imgContainer); // imgContainer를 preview 요소에 추가합니다.
//         });
//         reader.readAsDataURL(file); // 파일을 데이터 URL로 읽습니다.
//     });
// }
//
// // 속성과 자식을 가진 요소를 생성하는 도우미 함수입니다.
// function el(nodeName, attributes, ...children) {
//     const node =
//         nodeName === "fragment"
//             ? document.createDocumentFragment() // nodeName이 "fragment"인 경우 DocumentFragment를 생성합니다.
//             : document.createElement(nodeName); // 그렇지 않은 경우 nodeName을 가진 새 요소를 생성합니다.
//
//     Object.entries(attributes).forEach(([key, value]) => {
//         // 속성 항목을 반복합니다.
//         if (key === "events") {
//             // key가 "events"인 경우, 노드에 이벤트 리스너를 추가합니다.
//             Object.entries(value).forEach(([type, listener]) => {
//                 node.addEventListener(type, listener); // 지정된 유형과 리스너로 이벤트 리스너를 추가합니다.
//             });
//         } else if (key in node) {
//             try {
//                 node[key] = value; // 노드에 속성이 이미 있는 경우, 속성을 직접 설정합니다.
//             } catch (err) {
//                 node.setAttribute(key, value); // 그렇지 않은 경우, setAttribute()를 사용하여 속성을 설정합니다.
//             }
//         } else {
//             node.setAttribute(key, value); // 노드에 속성이 없는 경우, setAttribute()를 사용하여 속성을 설정합니다.
//         }
//     });
//
//     children.forEach((childNode) => {
//         // 자식 요소를 노드에 추가합니다.
//         if (typeof childNode === "string") {
//             //JavaScript에서 == 연산자는 두 값이 동일하거나 동일한 유형인지 여부를 검사합니다. 예를 들어, Java에서 "1" == 1은 true를 반환하지만, JavaScript에서 "1" == 1은 false를 반환합니다. 이는 JavaScript에서 "1"은 문자열이고 1은 숫자이기 때문입니다.
//             // JavaScript에서 == 연산자를 사용하여 두 값이 동일한지 여부를 검사하려면 === 연산자를 사용해야 합니다. === 연산자는 두 값의 값과 유형을 모두 비교합니다. 따라서 JavaScript에서 "1" === 1은 true를 반환합니다.
//             node.appendChild(document.createTextNode(childNode)); // childNode가 문자열인 경우, 텍스트 노드를 생성하여 추가합니다.
//         } else {
//             node.appendChild(childNode); // 그렇지 않은 경우, childNode를 직접 추가합니다.
//         }
//     });
//
//     return node; // 생성된 노드를 반환합니다.
// }